# Sales App.

## Technologies.

- Ruby 3.0.4
- Ruby on Rails 7.0.7.2
- PSQL
- Docker


## Launch PSQL Docker Container - Local Development

1. Create a postgresql docker container: `docker run -p 5432:5432 --rm -e POSTGRES_PASSWORD=postgres -v pgdata:/var/lib/postgresql/data postgres`
