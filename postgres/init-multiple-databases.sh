#!/usr/bin/env bash
set -euo pipefail

psql -v ON_ERROR_STOP=1 --username "${POSTGRES_USER}" --dbname "${POSTGRES_DB}" <<-EOSQL
	CREATE DATABASE feed_db OWNER ${POSTGRES_USER};
	CREATE DATABASE profile_db OWNER ${POSTGRES_USER};
	CREATE DATABASE project_db OWNER ${POSTGRES_USER};
	CREATE DATABASE response_db OWNER ${POSTGRES_USER};
EOSQL
