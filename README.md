# Elephant on FHIR

This project provides an [IBM FHIR Server](https://github.com/IBM/FHIR) configured with a [PostgreSQL](https://hub.docker.com/_/postgres) database. [pgAdmin](https://www.pgadmin.org/) is included to support direct database queries.

This project is best used for evaluation and development as it includes all of the default settings and credentials utilized within the IBM FHIR Server distribution.

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

### FHIR Implementation Guides (Profiles)

The Elephant on FHIR docker compose configuration provides a volume mapping to support loading FHIR implementation guides/profiles. 
```shell script
      - ./fhir-server/userlib:/opt/ol/wlp/usr/servers/fhir-server/userlib
```
To load a profile, simply copy the appropriate jar file(s) to the userlib directory, prior to server startup.
To disable a profile, simply remove the jar file(s) from the userlib directory and restart the server, if necessary. The US Core profile is enabled by default.


For further information on implementation guide support, please consult the [IBM FHIR User Guide](https://ibm.github.io/FHIR/guides/FHIRValidationGuide#optional-profile-support).


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
