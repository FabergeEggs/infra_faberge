# Faberge Infrastructure

Repository with single Docker Compose to start, setup and run all the microservices architecture with multiple services, databases, and supporting infrastructure (redpanda).

## Core Infrastructure

### Redpanda (Message Broker)
- **Container:** `redpanda`
- **Ports:** 9092 (Kafka API), 9644 (Admin API), 8085 (Pandaproxy)
- **Purpose:** Event streaming and message queuing across services
- **Volume:** `redpanda_data`

### Redis
- **Container:** `redis`
- **Port:** 6379
- **Purpose:** Caching for Feed
- **Volume:** `redis_data`

### Mailhog (Email Testing)
- **Container:** `mailhog`
- **Ports:** 1025 (SMTP), 8025 (Web UI)
- **Purpose:** Indevelopment email
- **Volume:** `mailhog_data`

## Authentication & Authorization

### Keycloak
- **Container:** `keycloak`
- **Port:** 8082
- **Purpose:** Identity provider and authentication server
- **Dependencies:** Mailhog (email sending)
- **Configuration:** Imports realm from `keycloak-export/`, applies custom themes from `keycloak-themes/`
- **Volume:** `keycloak_data`

## Services

### Auth Service
- **Container:** `auth-service`
- **Port:** 8000
- **Language:** Python
- **Purpose:** Authentication API, manages user sessions and tokens
- **Dependencies:** Keycloak, Mailhog, Redpanda
- **Build:** From `../auth_service`
- **Repository:** https://github.com/FabergeEggs/auth_service

### Profile Service
- **Container:** `profile-service`
- **Port:** 8001
- **Language:** Python
- **Purpose:** User profile management
- **Dependencies:** PostgreSQL (profile_db), Redpanda, Media Service
- **Database:** `postgres-profile` on port 5433
- **Build:** From `../profile_service`
- **Repository:** https://github.com/FabergeEggs/profile_service

### Project Service
- **Container:** `project-service`
- **Port:** 8003
- **Language:** Python
- **Purpose:** Project and it content management
- **Dependencies:** PostgreSQL (project_db), Redpanda
- **Database:** `postgres-project` on port 5434
- **Migrations:** Run automatically on startup
- **Build:** From `../project_service`
- **Repository:** https://github.com/FabergeEggs/project_service

### Feed Service
- **Container:** `feed-service`
- **Port:** 4000
- **Language:** Elixir/Phoenix
- **Purpose:** Feed
- **Dependencies:** PostgreSQL (feed_db), Redpanda, Redis
- **Database:** `postgres-feed` on port 5435
- **Build:** From `../feed_service`
- **Repository:** https://github.com/FabergeEggs/feed_service

### Media Service
- **Container:** `media-service`
- **Port:** 8004
- **Language:** Elixir/Phoenix
- **Purpose:** Media storage and processing
- **Dependencies:** PostgreSQL (media_db), Redpanda, Redis, MinIO
- **Database:** `postgres-media` on port 5436
- **Object Storage:** MinIO (see below)
- **Build:** From `../media_service`
- **Repository:** https://github.com/FabergeEggs/media_service

## Storage & File Management

### MinIO
- **Container:** `minio`
- **Ports:** 9000 (API), 9001 (Console)
- **Purpose:** S3-compatible object storage for media files
- **Default Credentials:** minioadmin / minioadmin
- **Volume:** `minio_data`

## API & Frontend

### API Gateway
- **Container:** `api-gateway`
- **Port:** 8080
- **Purpose:** Unified entry point routing requests to services
- **Dependencies:** All backend services
- **Build:** From `../apigateway`
- **Repository:** https://github.com/FabergeEggs/apigateway

### Frontend
- **Container:** `frontend`
- **Port:** 3000
- **Language:** Next.js
- **Purpose:** Web application UI
- **Dependencies:** API Gateway
- **Build:** From `../frontend` (dev target)
- **Repository:** https://github.com/FabergeEggs/frontend

## Network

All services communicate via the `app-network` bridge network. The setup includes health checks and proper service dependencies to ensure services start in the correct order.

## Environment Variables

Configuration is managed through environment variables. Key variables include:
- Keycloak credentials and configuration
- Database credentials for each service
- Service URLs and hostnames
- Redis and Kafka broker settings
- MinIO credentials and configuration
