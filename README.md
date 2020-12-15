# Elephant on FHIR

This project provides an [IBM FHIR Server](https://github.com/IBM/FHIR) configured with a [PostgreSQL](https://hub.docker.com/_/postgres) database. [pgAdmin](https://www.pgadmin.org/) is included to support direct database queries.

This project is best used for evaluation and development as it includes all of the default settings and credentials utlized within the IBM FHIR Server.

## Quickstart

### Project Setup

Launch the PostgreSQL and pgAdmin containers:
```shell script
docker-compose up -d ibm-fhir-db pgadmin
```

Create the IBM FHIR schema using the IBM FHIR schema tool container. Process information is logged to `out.log` in the current directory:
```shell script
./fhir-schema-tool.sh
```

Start the FHIR Server container:
```shell script
docker-compose up -d
```

Use the FHIR Server's Healthcheck status to determine availability (will take at least 60 seconds):
```shell script
docker-compose ps
``` 

### Send Requests

Send a test request to the server. Note that FHIR Server ships with a self-signed certificate. The following cURL command uses the `-k` switch to disable validation.

```shell script
 curl -k -i -u 'fhiruser:change-password' 'https://localhost:9443/fhir-server/api/v4/$healthcheck'
```

### pgAdmin Configuration

The pgadmin web UI is available on http://localhost:8090. 
Credentials are pgdba@email.com/change-password.

Once logged in, configure a connection using the following parameters:
- server name/host: ibm-fhir-db
- port: 5432
- database: fhirdb
- username: fhirserver
- password: change-password

## Additional Documentation

- [IBM FHIR Server On GitHub](https://github.com/IBM/FHIR)
- [IBM FHIR Server on DockerHub](https://hub.docker.com/r/ibmcom/ibm-fhir-server)
- [IBM FHIR Server User's Guide](https://ibm.github.io/FHIR/guides/FHIRServerUsersGuide)
