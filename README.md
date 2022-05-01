# proj-template

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/andreif/proj-template)

This template is using https://github.com/andreif/proj for opinionated Django setup.

Create Heroku app using the deploy button:

- Connect your GitHub account to Heroku if the new repo is private.
- Specify `DJANGO_ALLOWED_HOSTS` env var matching your app name in the form shown after pressing the button above.
- Point Deployment method to your GitHub repo and enable automatic deploys.
- Use the web UI to run `python src/manage.py createsuperuser`.

## Setting up a new project manually

Pre-requisites:

```sh
brew install libpq

sudo ln -s ${PG_BIN}/createdb
sudo ln -s ${PG_BIN}/dropdb
sudo ln -s ${PG_BIN}/pg_config

brew install libmemcached
export CPPFLAGS="-I/opt/homebrew/include"
export PIPENV_VENV_IN_PROJECT=1
```
Add `127.0.0.1 postgres` to `/etc/hosts`.
Add the env vars to Makefile run configuration template in PyCharm.

Repo and local setup:

- Create a new repo using this template https://github.com/andreif/proj-template and clone locally
- Change the deploy URL above in this readme.
- Start Postgres app/container.
- `make setup`
- `make server` to run local Django server
- Commit `Pipfile.lock`.

Heroku:

- `brew tap heroku/brew && brew install heroku`
- E.g.: `APP=my-heroku-app make heroku-create; make heroku-setup`
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

### Updating requirements and stack

```
make update-dependencies

heroku stack:set heroku-20
```


## From zero to hero with GitHub CLI

Git setup

```
$ git config --global init.defaultBranch main
```

On macOS

```sh
$ brew install gh
$ gh auth login

# ! First copy your one-time code: 1234-5678
# - Press Enter to open github.com in your browser...
# ✓ Authentication complete. Press Enter to continue...

# ✓ Logged in as andreif

$ gh repo create --confirm --public 0mgs/demo --template https://github.com/andreif/proj-template

# ✓ Created repository 0mgs/demo on GitHub
# Initialized empty Git repository in /Users/name/demo/.git/
# remote: Enumerating objects: 30, done.
# remote: Counting objects: 100% (30/30), done.
# remote: Compressing objects: 100% (24/24), done.
# remote: Total 30 (delta 0), reused 18 (delta 0), pack-reused 0
# Unpacking objects: 100% (30/30), 5.72 KiB | 279.00 KiB/s, done.
# From https://github.com/0mgs/demo
#  * [new branch]      main       -> origin/main
# Branch 'main' set up to track remote branch 'main' from 'origin'.
# Already on 'main'
# ✓ Initialized repository in "demo"

$ cd demo
```

## Heroku CLI

```sh
$ brew tap heroku/brew 
$ brew install heroku
$ heroku auth:login

# ...
```
