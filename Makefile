.PHONY: start stop restart build logs shell test clean help

start: ## Start the application
	docker compose up --build -d
	@echo "Application is starting..."
	@echo "Website: http://localhost:8080"
	@echo "Use 'make logs' to see the logs"

stop: ## Stop the application
	docker compose down

restart: stop start ## Restart the application

build: ## Rebuild all containers
	docker compose build
	docker compose up -d
	docker compose exec php composer install
	docker compose exec node yarn install
	docker compose exec node yarn build
	docker compose exec php bin/console doctrine:database:create --if-not-exists
	docker compose exec php bin/console doctrine:migrations:migrate --no-interaction

logs: ## Show logs from containers
	docker compose logs -f

shell: ## Access PHP container shell
	docker compose exec php bash

test: ## Run tests
	docker compose exec php bin/phpunit

clean: ## Remove all containers and volumes
	docker compose down -v --remove-orphans
	rm -rf var/cache/*

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

