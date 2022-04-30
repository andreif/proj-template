include local.env

PY = $(shell cut -d'-' -f2 < runtime.txt)
PROJECT := app
HEROKU_APP := change-me
# TODO: use regex:
DATABASE := $(shell cat local.env | grep DATABASE_URL | cut -d'/' -f4 | head -n1)
ADMIN := $(shell cat local.env | grep DJANGO_ADMIN_URL | cut -d'=' -f2)
SOURCE_COMMIT := $(shell git rev-parse HEAD)
ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(ARGS):;@:)

.DEFAULT_GOAL := help


.PHONY: help  # shows available commands
help: Makefile
	@echo "\nAvailable commands:\n"
	@sed -n 's/^.PHONY:\(.*\)/ *\1/p' $<
	@echo


check_env:
	@test -n "${PY}"
	@test -n "${PROJECT}"
	@test -n "${SOURCE_COMMIT}"
	@test -n "${DATABASE}"
	@test -n "${HEROKU_APP}"
	@test -n "${ADMIN}"
	@which createdb dropdb pg_config


.PHONY: build
build: check_env
	docker-compose build --build-arg SOURCE_COMMIT=${SOURCE_COMMIT} app
	docker-compose up -d app
	docker-compose logs -f --tail=200 app


.PHONY: logs
logs:
	docker-compose logs -f --tail=200 app


.PHONY: manage
manage: check_env
	SOURCE_COMMIT=${SOURCE_COMMIT} \
	PIPENV_IGNORE_VIRTUALENVS=1 \
	pipenv run python src/manage.py ${ARGS}
#env $(shell cat local.env | xargs) \


.PHONY: server
server:
	make manage runserver


.PHONY: migrations
migrations:
	make manage makemigrations
	make manage migrate


.PHONY: task
task:
	pipenv run python src/${PROJECT}/tasks.py ${ARGS}


.PHONY: requirements
requirements:
	pipenv lock --requirements > requirements.txt


.PHONY: setup
setup: check_env
	pyenv install --skip-existing ${PY}
	pyenv local ${PY}
	pip install -U pip pipenv
	pipenv install --dev
	createdb ${DATABASE} || true
	test -e .env || ln -s local.env .env
	make manage migrate
	make manage createsuperuser


.PHONY: clean
clean: check_env
	pipenv --rm || true
	dropdb ${DATABASE}


.PHONY: venv
venv:
	pipenv shell


.PHONY: version
version:
	heroku config:set SOURCE_COMMIT=$(shell git rev-parse --short master)


.PHONY: deploy
deploy:
	git push heroku main ${GIT_ARGS} 2>&1 | tee /dev/tty | grep "Verifying deploy... done."
	make version
	heroku logs


.PHONY: deploy-force
deploy-force:
	GIT_ARGS=--force make deploy


.PHONY: heroku-setup
heroku-setup: check_env
	heroku git:remote --app ${HEROKU_APP}  # or git remote add heroku https://git.heroku.com/${HEROKU_APP}.git
	heroku addons:add heroku-postgresql:hobby-dev
	heroku addons:add memcachier:dev
	heroku addons:add sentry:f1
	heroku addons:add newrelic:wayne
	heroku addons:create scheduler:standard

	heroku config:set DJANGO_SETTINGS_MODULE=app.settings
	heroku config:set DJANGO_ALLOWED_HOSTS=${HEROKU_APP}.herokuapp.com
	heroku config:set DJANGO_ADMIN_URL="${ADMIN}"
	heroku config:set DISABLE_COLLECTSTATIC=
	heroku config:set DJANGO_SECRET_KEY="$(shell openssl rand -base64 32)"


.PHONY: heroku-user
heroku-user:
	heroku run python src/manage.py createsuperuser


.PHONY: update-dependencies
update-dependencies:
	rm Pipfile.lock
	pipenv install

podman:
	podman machine stop podman-machine-default || true
	podman machine rm podman-machine-default --force || true
	podman machine init -v "$(shell pwd):$(shell pwd)"
	podman machine start
