.PHONY: up down build install dev prod clean

up: ## Start the development environment
	docker-compose up -d

down: ## Stop the development environment
	docker-compose down

build: ## Build all containers
	docker-compose build --no-cache

install: build ## First time installation
	docker-compose up -d
	docker-compose exec php bin/console doctrine:migrations:migrate --no-interaction
	docker-compose exec php bin/console assets:install
	docker-compose exec node yarn install
	docker-compose exec node yarn build

dev: up ## Start development environment
	@echo "Development environment running at http://localhost:8080"

prod: ## Build for production
	docker-compose -f docker-compose.prod.yml up -d

clean: down ## Clean up the environment
	docker-compose down -v --remove-orphans
	rm -rf vendor node_modules var/cache/*

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
