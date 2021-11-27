# proj-template

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/andreif/proj-template)

## Setting up a new project

- Create a new repo using this template https://github.com/andreif/proj-template and clone locally
- Change admin URL in `src/app/urls.py` because the one from template is well-known and the admin URL shouls be secret.
- Start Postgres app or container.
- `make setup`
- `make server`

Heroku

- create heroku app
- heroku git:remote -a myapp
   - or: git remote add heroku https://git.heroku.com/{myapp}.git
- set deploy method to `github`
- enable automatic deploys
- make setup-heroku

Deploy

```
git push github main  # or:
git push heroku main 
heroku run python src/manage.py createsuperuser
```

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
