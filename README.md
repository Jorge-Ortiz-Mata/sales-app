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

In order to test the production environment of your Rails application app, you will need to build and run the production image.
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
