#!/usr/bin/env bash
set -euo pipefail

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<-EOSQL
    -- Создаем базы данных если их нет (для Postgres 16)
    SELECT 'CREATE DATABASE feed_db OWNER ${POSTGRES_USER}'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'feed_db')\gexec
    SELECT 'CREATE DATABASE profile_db OWNER ${POSTGRES_USER}'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'profile_db')\gexec
    SELECT 'CREATE DATABASE project_db OWNER ${POSTGRES_USER}'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'project_db')\gexec
    SELECT 'CREATE DATABASE response_db OWNER ${POSTGRES_USER}'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'response_db')\gexec
    SELECT 'CREATE DATABASE keycloak OWNER ${POSTGRES_USER}'
    WHERE NOT EXISTS (SELECT FROM pg_database WHERE datname = 'keycloak')\gexec
EOSQL