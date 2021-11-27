# proj-template

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/andreif/proj-template)

This template is using https://github.com/andreif/proj for opinionated Django setup.

Create Heroku app using the deploy button:

- Connect your GitHub account to Heroku if the new repo is private.
- Specify `DJANGO_ALLOWED_HOSTS` env var matching your app name in the form shown after pressing the button above.
- Point Deployment method to your GitHub repo and enable automatic deploys.
- Use the web UI to run `python src/manage.py createsuperuser`.

## Setting up a new project manually

Repo and local setup:

- Create a new repo using this template https://github.com/andreif/proj-template and clone locally
- Change the deploy URL above in this readme.
- Start Postgres app/container.
- `make setup`
- `make server` to run local Django server
- Commit `Pipfile.lock`.

Heroku:

- E.g.: `APP=myapp ADMIN=changeme make heroku-setup`
- In web UI, set deploy method to `GitHub` and enable automatic deploys.
- `git push github main` or `git push heroku main`
- `make heroku-user`

Troubleshooting

```sh
heroku config
heroku run env | sort
```

Labs

```
heroku labs:enable runtime-dyno-metadata
heroku labs:enable metrics-beta
# heroku labs:enable log-runtime-metrics
heroku labs
```

### Upgrade requirements

```
make update-dependencies
```

### Stack update

```
heroku stack:set heroku-20
```

### From scratch

```
pipenv install -e git+https://github.com/andreif/proj.git#egg=proj
```
