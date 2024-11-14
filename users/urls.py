from rest_framework.routers import SimpleRouter
from materials.apps import MaterialsConfig

from users.views import PaymentsViewSet

router = SimpleRouter()


router.register(r'payments', PaymentsViewSet, basename='payments')

app_name = MaterialsConfig.name

urlpatterns = []

urlpatterns += router.urls