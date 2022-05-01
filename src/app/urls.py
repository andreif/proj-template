from django.conf import settings
from django.contrib import admin
from django.urls import path, re_path, reverse
from . import views

urlpatterns = [
    path('', views.index_view, name='index'),
    path('examples/<int:examples_id>', view=views.example_view, name='example'),
    re_path(r'^examples/?$', view=views.index_view, name='examples'),
    path(settings.ADMIN_URL, admin.site.urls),
]


def _id(id_or_instance):
    return id_or_instance if isinstance(id_or_instance, int) else id_or_instance.id


class URLs:
    def __getattr__(self, item):
        return reverse(item)

    def example(self, example):
        return reverse('example', args=[_id(example)])


urls = URLs()
