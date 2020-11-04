# MDL Search

An implementation of the [Blacklight Search](http://projectblacklight.org/) platform.

# Developer Quickstart

## Install The App

* [Install Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* [Install Docker Compose](https://docs.docker.com/compose/)

Clone this repository and copy in the .env file

`$ cp .env-example .env`

Configure the GeoNames credentials in the `.env` file:

```
GEONAMES_USER=<ADD USER HERE>
GEONAMES_TOKEN=<ADD TOKEN HERE>
```

Initialize and start the local dev environment:

`$ ./local-dev-init.sh`

__Note__: you will be prompted for a password. Use your `sudo` / machine admin password here.

You'll see something like the following eventually appear in your terminal:

```
=> Booting Puma
web_1        | => Rails 5.1.2 application starting in development on http://0.0.0.0:3000
web_1        | => Run `rails server -h` for more startup options
```

Once the rails server has booted, open [http://localhost:3000/](http://localhost:3000/) in yourbrowser.

## Ingest Some Content

Once the app is up and running, open another container and run the following command to ingest and index some content:

`$ docker-compose exec web rake 'mdl_ingester:collection[p15160coll13]'`
`$ docker-compose exec web rake 'mdl_ingester:collection[p16022coll10]'`

Once the ingest sidekiq jobs have completed:

`$ docker-compose exec web rake solr:commit`

## Interacting with the App on the Command Line

Enter an interactive session with the application (must be running in another tab):

`$ docker-compose exec web /bin/bash`

Replace `/bin/bash` with `rails console` to skip right to a Rails console session.

Execute a task in the Rails Test Environment (e.g. run some tests):

`$ docker-compose exec -e "RAILS_ENV=test" web respec`


## Troubleshooting

* [MySQL] If you run into issues with the database, try nuking the db volumes and restarting:
  * `$ docker-compose down -v; docker-compose up`

# Updating React Components

The two React dependencies associated with this project are included in the `package.json` file and tied to specific commits:

```json
  ...
    "react-borealis": "git+https://github.com/UMNLibraries/react-borealis.git#e305e7fd6f4c",
    "react-citation": "git+https://github.com/UMNLibraries/react-citation.git#52091d617b5d",
  ...
```

After running the production build process on one of these projects and pushing the new files to GitHub, include the new commit hash in the `mdl_search` project `package.json` file and run the following command (located in the root directory of this repo): `./yarn_rebuild.sh`.

For more details on how to develop and build these React components, see the [React Borealis project page](https://github.com/UMNLibraries/react-borealis).

# Testing

A complete test environment comes package with `mdl_search`. This includes a test Solr instance as well as a separate running web application test instance.

To run the test suite: `./docker-compose-test rspec`

Note: The `./docker-compose-test` simply executes commands against the `web` service running in your app and sets the Rails Environment to "test".

There is a single, standardized Solr test instance (temporarily) stored on [Dockerhub](https://cloud.docker.com/repository/registry-1.docker.io/cfennell/mdl_solr/tags). Any container storage system (e.g. Artifactory docker) could store this container. This instance contains a handful of representative records and can be updated as new test cases are identified.

### Watching Your Functional Tests (Helpful for Debugging)

The Reflections `docker-compose.yml` comes equipped with a selenium server running VNC. To watch Selenium as it drives the test browser, install a [VNC Viewer](https://www.realvnc.com/en/connect/download/viewer/) and connect it to `http://localhost:5900` with the password "`secret`".


# Developer Tips

* "How to I add/remove/change X feature in the UI?"
  * MDL Search makes use of a [Rails Engine](https://guides.rubyonrails.org/engines.html) called "[Blacklight](https://github.com/projectblacklight/blacklight)". Rails engines are like little Rails apps that you override within your own app. If there is a UI feature you want to alter or remove, you may need to hunt around a bit in Blacklight to find it. Tip: browse the HTML source of the feature you are looking for and search the Blacklight view codebase (for your [specific version](https://github.com/projectblacklight/blacklight/tree/v6.10.1/app/views)) for small unique html snippets from the interface; sometimes you'll get lucky. Other times, you may have to browse through template render calls until you find what you are looking for.

# Docker Help

## Some aliases for your shell

```bash
# Note: you might consider adding aliases (shortcuts) in your shell env to make it easier to run these commands. e.g.:
# alias dps='docker ps -a'

# Show all docker images
$ docker ps -a

# Force Remove all MDL images
$ docker-compose stop; docker rmi -f $(docker images -q --filter="reference=mdl*")

# Remove all inactive Docker images (ones that have "Exited")
$ docker rm $(docker ps -a | grep Exited | awk '\''BEGIN { FS=" " } ; {print $1;}'\'')

# CAREFUL! Scorched earth! remove all Docker images
$ docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
```

## Usefull Tools

* [Docker Dive](https://github.com/wagoodman/dive)

This is especially useful for analyzing containers to see why they are the size that they are and finding ways to slim them down.
