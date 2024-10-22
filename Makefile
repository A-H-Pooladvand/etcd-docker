# Define variables (adjust if needed)
COMPOSE_FILE = docker-compose.yml

# Phony targets to avoid warnings
.PHONY: all build up down ps logs clean restart

all: build

build:
	@echo "Building Docker images..."
	@docker-compose build

up: build
	@echo "Starting services..."
	@docker-compose up -d

down:
	@echo "Stopping and removing services..."
	@docker-compose down

ps:
	@echo "Showing container status..."
	@docker-compose ps

logs: service
	@echo "Showing logs for $(service)..."
	@docker-compose logs $(service)

clean: down
	@echo "Removing volumes..."
	@docker-compose down --volumes

restart:
	@echo "Restarting services..."
	@docker-compose restart

# Allow specifying a service for logs command
service:

