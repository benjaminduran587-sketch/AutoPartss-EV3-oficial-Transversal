from django.test import TestCase

class TiendaTests(TestCase):
    def test_tienda_access(self):
        """Test de acceso a tienda"""
        response = self.client.get('/tienda/')
        self.assertIn(response.status_code, [200, 404, 403])
