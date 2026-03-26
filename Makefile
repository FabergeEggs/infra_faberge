COMPOSE_FILE=mega-compose.yaml
COMPOSE_CORE = -f mega-compose.yaml
COMPOSE_FRONT_LOCAL = -f frontend-local-compose.yaml

up:
	docker compose -f $(COMPOSE_FILE) up

down:
	docker compose -f $(COMPOSE_FILE) down

frontend-latest:
	FRONTEND_BUILD_CONTEXT=../frontend \
	FRONTEND_VOLUME=../frontend:/frontend \
	VERSION=latest \
	docker compose $(COMPOSE_CORE) $(COMPOSE_FRONT_LOCAL) build frontend && \
	docker compose $(COMPOSE_CORE) $(COMPOSE_FRONT_LOCAL) up
# 	FRONTEND_BUILD_CONTEXT=../frontend \
# 	FRONTEND_VOLUME=../frontend:/app \
# 	FRONTEND_IMAGE=faberge-frontend-local \
# 	VERSION=latest \
# 	docker compose -f $(COMPOSE_FILE) build frontend && \
# 	docker compose -f $(COMPOSE_FILE) up frontend

frontend-dev:
	FRONTEND_BUILD_CONTEXT=../frontend \
	FRONTEND_VOLUME=../frontend:/app \
	FRONTEND_IMAGE= \
	VERSION=dev \
	docker compose -f $(COMPOSE_FILE) up --build frontend

auth-dev:
	KEYCLOAK_EXPORT_VOLUME=../auth_service/keycloak-export:/opt/keycloak/data/import:ro
	AUTH_BUILD_CONTEXT=../auth_service \
	AUTH_VOLUME=../auth_service:/app \
	AUTH_IMAGE= \
	VERSION=dev \
	docker compose -f $(COMPOSE_FILE) up

auth-latest:
	KEYCLOAK_EXPORT_VOLUME=../auth_service/keycloak-export:/opt/keycloak/data/import:ro
	AUTH_BUILD_CONTEXT=../auth_service \
	AUTH_VOLUME=../auth_service:/app \
	AUTH_IMAGE= \
	VERSION=latest \
	docker compose -f $(COMPOSE_FILE) up

project-dev:
	PROJECT_BUILD_CONTEXT=../project_service \
	PROJECT_VOLUME=../project_service:/app \
	PROJECT_IMAGE= \
	VERSION=dev \
	docker compose -f $(COMPOSE_FILE) up

project-latest:
	PROJECT_BUILD_CONTEXT=../project_service \
	PROJECT_VOLUME=../project_service:/app \
	PROJECT_IMAGE= \
	VERSION=latest \
	docker compose -f $(COMPOSE_FILE) up

feed-dev:
	FEED_BUILD_CONTEXT=../feed_service \
	FEED_VOLUME=../feed_service:/app \
	FEED_IMAGE= \
	VERSION=dev \
	docker compose -f $(COMPOSE_FILE) up

feed-latest:
	FEED_BUILD_CONTEXT=../feed_service \
	FEED_VOLUME=../feed_service:/app \
	FEED_IMAGE= \
	VERSION=latest \
	docker compose -f $(COMPOSE_FILE) up

profile-dev:
	PROFILE_BUILD_CONTEXT=../profile_service \
	PROFILE_VOLUME=../profile_service:/app \
	PROFILE_IMAGE= \
	VERSION=dev \
	docker compose -f $(COMPOSE_FILE) up

profile-latest:
	PROFILE_BUILD_CONTEXT=../profile_service \
	PROFILE_VOLUME=../profile_service:/app \
	PROFILE_IMAGE= \
	VERSION=latest \
	docker compose -f $(COMPOSE_FILE) up

media-dev:
	MEDIA_BUILD_CONTEXT=../media_service \
	MEDIA_VOLUME=../media_service:/app \
	MEDIA_IMAGE= \
	VERSION=dev \
	docker compose -f $(COMPOSE_FILE) up

media-latest:
	MEDIA_BUILD_CONTEXT=../media_service \
	MEDIA_VOLUME=../media_service:/app \
	MEDIA_IMAGE= \
	VERSION=latest \
	docker compose -f $(COMPOSE_FILE) up

response-dev:
	RESPONSE_BUILD_CONTEXT=../response_service \
	RESPONSE_VOLUME=../response_service:/app \
	RESPONSE_IMAGE= \
	VERSION=dev \
	docker compose -f $(COMPOSE_FILE) up

response-latest:
	RESPONSE_BUILD_CONTEXT=../response_service \
	RESPONSE_VOLUME=../response_service:/app \
	RESPONSE_IMAGE= \
	VERSION=latest \
	docker compose -f $(COMPOSE_FILE) up


all-dev:
	VERSION=dev \
	docker compose -f $(COMPOSE_FILE) up

all-latest:
	VERSION=latest \
	docker compose -f $(COMPOSE_FILE) up

all-local:
	AUTH_BUILD_CONTEXT=../auth_service \
	AUTH_VOLUME=../auth_service:/app \
	AUTH_IMAGE= \
	PROJECT_BUILD_CONTEXT=../project_service \
	PROJECT_VOLUME=../project_service:/app \
	PROJECT_IMAGE= \
	FEED_BUILD_CONTEXT=../feed_service \
	FEED_VOLUME=../feed_service:/app \
	FEED_IMAGE= \
	PROFILE_BUILD_CONTEXT=../profile_service \
	PROFILE_VOLUME=../profile_service:/app \
	PROFILE_IMAGE= \
	MEDIA_BUILD_CONTEXT=../media_service \
	MEDIA_VOLUME=../media_service:/app \
	MEDIA_IMAGE= \
	RESPONSE_BUILD_CONTEXT=../response_service \
	RESPONSE_VOLUME=../response_service:/app \
	RESPONSE_IMAGE= \
	docker compose -f $(COMPOSE_FILE) up