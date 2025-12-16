from django.test import TestCase

class FrontendTests(TestCase):
    def test_home_page(self):
        """Test que la página principal carga"""
        response = self.client.get('/')
        self.assertEqual(response.status_code, 200)
    
    def test_template_usage(self):
        """Test que verifica respuesta básica"""
        response = self.client.get('/')
        # Si la página existe, debería tener contenido
        if response.status_code == 200:
            self.assertTrue(len(response.content) > 0)
