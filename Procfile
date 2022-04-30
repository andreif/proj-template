web: cd ./src && pipenv run python ./manage.py migrate && pipenv run gunicorn proj.wsgi:application --log-file=- --config=./gunicorn-conf.py
