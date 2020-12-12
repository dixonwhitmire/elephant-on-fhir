#!/bin/bash
# creates the FHIR Database and User
# HEREDOC command format taken from https://hub.docker.com/_/postgres/
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER ${FHIR_DB_USER} WITH PASSWORD '${FHIR_DB_PASSWORD}';
    CREATE DATABASE ${FHIR_DB_NAME};
    GRANT ALL PRIVILEGES ON DATABASE ${FHIR_DB_NAME} TO ${FHIR_DB_USER};
EOSQL