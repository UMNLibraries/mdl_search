# MDL Search

An implementation of the [Blacklight Search](http://projectblacklight.org/) platform.

# Developer Quickstart

* [Install Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* [Install Docker Compose](https://docs.docker.com/compose/)

Initialize and start the local dev environment:

`./local-dev-init.sh`

## Ingest Some Content

Once the app is up and running, open another container and run the following command to ingest and index some content:

`docker-compose exec web rake 'mdl_ingester:collection[p16022coll27]`

Once the ingest sidekiq jobs have completed:

`docker-compose exec web rake solr:commit`

## Shelling Into The App

Enter an interactive session with the application:

`$ docker-compose exec web /bin/bash`

## Troubleshooting

* [MySQL] If you run into issues with the database, try nuking the db volumes and restarting:
  * `docker-compose down -v; docker-compose up`


# Docker Help

## Some aliases for your shell

```
# Show all docker images
alias dps='docker ps -a'

# Remove all MDL images
docker rmi $(docker images -q --filter="reference=mdl*")

# Remove all inactive Docker images (ones that have "Exited")
alias drm='docker rm $(docker ps -a | grep Exited | awk '\''BEGIN { FS=" " } ; {print $1;}'\'')'

# Scorched earth! remove all Docker images
alias drmi='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'
```