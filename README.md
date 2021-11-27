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


## GitHub CLI

```
$ brew install gh
$ gh auth login

# ! First copy your one-time code: 1234-5678
# - Press Enter to open github.com in your browser...
# ✓ Authentication complete. Press Enter to continue...

# ✓ Logged in as andreif
```

```
$ git config --global init.defaultBranch main

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
```
