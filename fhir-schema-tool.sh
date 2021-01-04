#!/bin/bash
# Executes the IBM FHIR Schema tools against a PostgreSQL DB.
# Usage:
# ./fhir-schema-tool.sh [onboard|offboard|debug|custom]

source .pgsql.env

SCHEMA_TOOL_MODE=${1:-onboard}
echo "FHIR Schema Tool is set to ${SCHEMA_TOOL_MODE} mode"

docker run  --rm \
            --name=schema-tool \
            --network=fhir \
            ibmcom/ibm-fhir-schematool:latest \
            --tool.behavior=${SCHEMA_TOOL_MODE} \
            --db.host=ibm-fhir-db \
            --db.port=5432 \
            --user=${FHIR_DB_USER} \
            --password=${FHIR_DB_PASSWORD} \
            --db.database=${FHIR_DB_NAME} \
            --schema.name.fhir=${FHIR_SCHEMA_NAME} \
            --grant.to=${FHIR_DB_USER} \
            --sslConnection=false \
            --db.type=postgresql | tee out.log