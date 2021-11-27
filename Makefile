include local.env

PY = 3.10.0  # TODO: read from runtime.txt
PROJECT := app
HEROKU_HOSTNAME := example.com
SOURCE_COMMIT := $(shell git rev-parse HEAD)
ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(ARGS):;@:)

.DEFAULT_GOAL := help


.PHONY: help  # shows available commands
help: Makefile
	@echo "\nAvailable commands:\n"
	@sed -n 's/^.PHONY:\(.*\)/ *\1/p' $<
	@echo


.PHONY: build
build:
	docker-compose build --build-arg SOURCE_COMMIT=$(SOURCE_COMMIT) app
	docker-compose up -d app
	docker-compose logs -f --tail=200 app


.PHONY: logs
logs:
	docker-compose logs -f --tail=200 app


.PHONY: manage
manage:
	SOURCE_COMMIT=$(SOURCE_COMMIT) \
	pipenv run src/manage.py $(ARGS)
#env $(shell cat local.env | xargs) \


.PHONY: server
server:
	make manage runserver


.PHONY: task
task:
	pipenv run python src/$(PROJECT)/tasks.py $(ARGS)


.PHONY: requirements
requirements:
	pipenv lock --requirements > requirements.txt


.PHONY: setup
setup:
	pyenv install --skip-existing $(PY)
	pyenv local $(PY)
	pip install -U pip pipenv
	pipenv install --dev
	createdb $(PROJECT) || true
	test -e .env || ln -s local.env .env
	make manage migrate
	make manage createsuperuser


.PHONY: clean
clean:
	pipenv --rm || true
	dropdb $(PROJECT)


.PHONY: venv
venv:
	pipenv shell


.PHONY: version
version:
	heroku config:set SOURCE_COMMIT=$(shell git rev-parse --short master)


.PHONY: deploy
deploy:
	git push heroku master $(GIT_ARGS) 2>&1 | tee /dev/tty | grep "Verifying deploy... done."
	make version
	heroku logs


.PHONY: deploy-force
deploy-force:
	GIT_ARGS=--force make deploy


.PHONY: setup-heroku
setup-heroku:
	heroku addons:add heroku-postgresql:hobby-dev
	heroku addons:add memcachier:dev
	heroku addons:add sentry:f1
	heroku addons:add newrelic:wayne
	heroku addons:create scheduler:standard

	heroku config:set DJANGO_SETTINGS_MODULE=app.settings
	heroku config:set DJANGO_ALLOWED_HOSTS=${HEROKU_HOSTNAME}
#	heroku config:set DJANGO_SECRET_KEY=[random string of choice]  # TODO: generate
	heroku config:set DISABLE_COLLECTSTATIC=


.PHONY: update-dependencies
update-dependencies:
	rm Pipenv.lock
	pipenv install
