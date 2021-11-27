from django.conf import settings
from django.contrib import admin
from django.urls import path
from . import views

urlpatterns = [
    path('', views.index_view, name='index'),
    path(settings.DJANGO_ADMIN_URL, admin.site.urls),
]
