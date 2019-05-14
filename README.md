# MDL Search

An implementation of the [Blacklight Search](http://projectblacklight.org/) platform.

# Developer Quickstart

* [Install Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* [Install Docker Compose](https://docs.docker.com/compose/)

Initialize and start the local dev environment:

`./local-dev-init.sh`

# Handy Docker Commands

## Some aliases for your shell

```
# Show all docker images
alias dps='docker ps -a'

# Remove all inactive Docker images (ones that have "Exited")
alias drm='docker rm $(docker ps -a | grep Exited | awk '\''BEGIN { FS=" " } ; {print $1;}'\'')'

# Scorched earth! remove all Docker images
alias drmi='docker rmi $(docker images | grep "^<none>" | awk "{print $3}")'
```

## Ingest Some Content

`docker-compose exec web rake 'mdl_ingester:collection[p16022coll27]`

Once the ingester has completed:

`docker-compose exec web rake solr:commit`

## Shelling Into The App

Enter an interactive session with the application:

`$ docker-compose exec web /bin/bash`



## Troubleshooting

* [MySQL] If you run into issues with the database, try nuking the db volumes and restarting:
  * `docker-compose down -v; docker-compose up`