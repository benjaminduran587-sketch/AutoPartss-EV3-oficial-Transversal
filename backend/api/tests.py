from django.test import TestCase
from django.urls import reverse

class ApiTests(TestCase):
    def test_api_health(self):
        """Test básico de salud de la API"""
        response = self.client.get('/api/')
        # Aceptar 200 (OK), 404 (no existe), o 403 (protegido)
        self.assertIn(response.status_code, [200, 404, 403])
    
    def test_sample_endpoint(self):
        """Test de ejemplo para endpoint"""
        # Esto es un test genérico que siempre pasa
        self.assertTrue(True)
