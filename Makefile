# Detect the Docker Compose command (V1 or V2)
DOCKER_COMPOSE := $(shell if command -v docker-compose >/dev/null 2>&1; then echo "docker-compose"; else echo "docker compose"; fi)

.PHONY: start stop restart build logs shell test clean help

start: build ## Start the application
	$(DOCKER_COMPOSE) up -d
	@echo "Application is starting..."
	@echo "Website: http://localhost:8080"
	@echo "Use 'make logs' to see the logs"

stop: ## Stop the application
	$(DOCKER_COMPOSE) down

restart: stop start ## Restart the application

build: ## Rebuild all containers
	docker compose build --no-cache
	docker compose up -d
	docker compose exec php composer install
	docker compose exec node yarn install
	docker compose exec node yarn build
	docker compose exec php bin/console doctrine:database:create --if-not-exists
	docker compose exec php bin/console make:migration
	docker compose exec php bin/console doctrine:migrations:migrate --no-interaction

logs: ## Show logs from containers
	$(DOCKER_COMPOSE) logs -f

shell: ## Access PHP container shell
	$(DOCKER_COMPOSE) exec php bash

test: ## Run tests
	$(DOCKER_COMPOSE) exec php bin/phpunit

clean: ## Remove all containers and volumes
	$(DOCKER_COMPOSE) down -v --remove-orphans
	rm -rf var/cache/*

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
