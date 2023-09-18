# Sales App.

## ENV environment variables required.

In order to deploy this web application to any web server, you should have to add the following environment variables in the project configuration.

* Development

- GCP_JSON: Store files in Google Cloud Storage
- SENDGRID_EMAIL_VALID: A valid email for send emails
- SENDGRID_API_KEY: The API key to send emails

* Production in local computer

- PSQL_URI: Database URL for production
- GCP_JSON: Store files in Google Cloud Storage
- SENDGRID_EMAIL_VALID: A valid email for send emails
- SENDGRID_API_KEY: The API key to send emails

* Production

- RAILS_MASTER_KEY: The rails mater key must be added.
- PSQL_URI: Database URL for production
- GCP_JSON: Store files in Google Cloud Storage
- SENDGRID_EMAIL_VALID: A valid email for send emails
- SENDGRID_API_KEY: The API key to send emails

Notes:

The GCP value must be added between 'apiKey1234' for development purposes. In production, make sure to delete the single quotes ''.

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
docker run -p 5432:5432 --rm --name postgresql-container -e POSTGRES_PASSWORD=postgres -v pgdata:/var/lib/postgresql/data postgres
```

## Launch the Rails Docker Image - Production environment.

In order to test the production environment of your Rails application app in your local computer, you will need to build and run the production image.
Make sure to have a dummy database created somewhere. Localhost is not been taken for the production environment.

* Build the production Docker Image

```bash
docker build -t sales-app-production:latest .
```

* Run the production Docker Image

```bash
docker run -p 3000:3000 --rm --name sales-app-production --env-file ./.env sales-app-production:latest
```

## Render Deployment

Before to get started, the PSQL database is not available through the API service. The staging and the production databases must be created manually.

For each Pull Request created, the ElephantSQL service will be taken instead.

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

That's all. Make sure to ignore your credentials in the .gitignore file.
