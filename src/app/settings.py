from proj.settings import *

ROOT_URLCONF = 'app.urls'
INSTALLED_APPS += [
    'app',
]

TEMPLATES[0]['OPTIONS']['context_processors'] += [
    'app.views.view_context',
]
