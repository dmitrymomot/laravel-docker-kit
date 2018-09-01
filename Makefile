.PHONY: init start deps  stop down restart php migrate seed test logs artisan composer pma deploy-dev start-dev

init:
	cp .env.docker .env
	docker-compose build && \
	make start
	make deps
	make migrate
	make seed

start:
	cp .env.docker .env
	docker-compose -f docker-compose.yml up --build -d nginx

deps:
	docker-compose exec php composer install

stop:
	docker-compose -f docker-compose.yml stop

down:
	docker-compose -f docker-compose.yml down
	rm -vf .env

restart:
	make stop
	make start

php:
	docker-compose exec php bash

migrate:
	docker-compose exec php php artisan migrate

seed:
	docker-compose exec php php artisan db:seed

test:
	docker-compose exec -T php ./vendor/bin/phpunit --disallow-todo-tests --colors=always $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

logs:
	tail -f storage/logs/*

artisan:
	docker-compose exec php php artisan $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

composer:
	docker-compose exec php composer $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

pma:
	docker-compose up -d pma
