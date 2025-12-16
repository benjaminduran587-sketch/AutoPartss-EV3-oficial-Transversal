#!/bin/bash

echo "========================================="
echo "   SISTEMA DE PRUEBAS - AUTO PARTS"
echo "========================================="

# Guardar ubicación original
ORIGINAL_DIR=$(pwd)
echo "Directorio original: $ORIGINAL_DIR"

# Cambiar a backend si existe
if [ -d "backend" ]; then
    cd backend
    echo "✓ Cambiado a directorio: backend/"
else
    echo "✗ ERROR: No se encontró directorio 'backend/'"
    exit 1
fi

echo "Ubicación actual: $(pwd)"
echo ""

# Verificar estructura
if [ ! -f "manage.py" ]; then
    echo "✗ ERROR: manage.py no encontrado"
    exit 1
fi

echo "✓ Archivo manage.py encontrado"
echo ""

# ========================================
# PRIMERO: Ejecutar tests normales
# ========================================
echo "1. EJECUTANDO PRUEBAS DE DJANGO"
echo "--------------------------------"

# Ejecutar tests (Django manejará automáticamente la búsqueda)
echo "Ejecutando tests con Django..."
python manage.py test --verbosity=1

TEST_EXIT_CODE=$?
if [ $TEST_EXIT_CODE -eq 0 ]; then
    echo "✓ Tests Django COMPLETADOS exitosamente"
else
    echo "⚠ Tests Django encontraron problemas (código: $TEST_EXIT_CODE)"
fi

echo ""
echo ""

# ========================================
# SEGUNDO: Ejecutar coverage
# ========================================
echo "2. REPORTE DE COBERTURA"
echo "--------------------------------"

# Instalar coverage si no está
if ! command -v coverage &> /dev/null; then
    echo "Instalando coverage..."
    pip install coverage > /dev/null 2>&1
fi

echo "Generando reporte de cobertura..."

# Usar ruta absoluta para evitar problemas
REPORT_DIR="$ORIGINAL_DIR/coverage_report"

# Limpiar reporte anterior si existe
if [ -d "$REPORT_DIR" ]; then
    rm -rf "$REPORT_DIR"
fi

# Ejecutar coverage en el directorio actual
coverage run --source='.' manage.py test --verbosity=0

echo ""
echo "RESUMEN DE COBERTURA:"
coverage report

echo ""
echo "Generando reporte HTML..."
coverage html -d "$REPORT_DIR"

echo ""
echo "✓ Reporte HTML generado en: $REPORT_DIR/index.html"

# ========================================
# TERCERO: Volver al directorio original
# ========================================
cd "$ORIGINAL_DIR"

echo ""
echo "========================================="
echo "   ANÁLISIS COMPLETADO"
echo "========================================="
echo ""
echo "RESUMEN FINAL:"
echo "  • Tests ejecutados: ✓"
echo "  • Cobertura generada: ✓"
echo "  • Reporte HTML: $REPORT_DIR/index.html"
echo ""
echo "Para ver reporte detallado:"
echo "  • Abrir: $REPORT_DIR/index.html en tu navegador"
echo ""
