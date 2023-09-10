# Sales App.

## Technologies.

- Ruby 3.0.4
- Ruby on Rails 7.0.7.2
- PSQL
- Docker


## UX - UI Design Template.

This section shows the URL where the UX UI Design was taken for this web application.

https://dribbble.com/shots/21086272-Sales-Dashboard

## Launch PSQL Docker Container - Local Development

In order to launch the PostgreSQL Docker Container, in your terminal, run the following command:

```bash
docker run -p 5432:5432 --rm -e POSTGRES_PASSWORD=postgres -v pgdata:/var/lib/postgresql/data postgres
```

## Launch the Rails Docker Image - Production environment.

In order to test the production environment of your Rails application app in your local computer, you will need to build and run the production image.
Make sure to have a dummy database created somewhere. Localhost is not been taken for the production environment.

Make sure to have the API Keys within your .env file:

- PSQL_USERNAME
- PSQL_PASSWORD
- PSQL_URI

* Build the production Docker Image

```bash
docker build -t sales-app-production:latest .
```

* Run the production Docker Image

```bash
docker run -p 3000:3000 --rm --name sales-app-production --env-file ./.env sales-app-production:latest
```

## ElephantSQL

The ElephantSQL service was used to create databases for testing purposes using the API endpoint.

- API Documentation: https://www.elephantsql.com/docs/api.html
- API Endpoints documentation
- API Generate API Keys: https://customer.elephantsql.com/apikeys

This is an example of how to get the current instances from this account:

```bash
curl -u :XXXX-XXXXX-XXXXX-XXXXX https://customer.elephantsql.com/api/instances/
```

## Render Deployment

Before to get started, the PSQL database is not available through the API service. The staging and the production databases must be created manually.
For each Pull Request created, the ElephantSQL service will be taken instead.

* Create API Key: https://dashboard.render.com/u/settings#api-keys

Save your API Key in the.env file and in the repository configuration

* Environemt Variables

- RAILS_MASTER_KEY=""

## Google Cloud Storage.

In order to store files or images in Google Cloud follow the next steps

- Create a project in GCP and add a payment method.

- Create a service account with the role: Storage Admin - Administrador de almacenamiento.

- Generate the JSON file and copy the value.

- Paste the value in your .env file (use single quotes).

```
GCP_JSON='{ "type": "service_account", ..., "universe_domain": "googleapis.com"}'
```

- Update the google configuration at config/storage.yml

```yaml
google:
  service: GCS
  project: sales-app
  credentials: <%= ENV['GCP_JSON'] %>
  bucket: sales-app-bucket
```

- Update the active storage configuration in the config/environments folder.
