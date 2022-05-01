from django.shortcuts import render
from . import api


def urls():
    from .urls import urls
    return urls


def view_context(request):
    return {'api': api, 'urls': urls()}


def index_view(request):
    return render(request, 'index.html', context={})


def example_view(request, example_id):
    return render(request, 'index.html', context={})
