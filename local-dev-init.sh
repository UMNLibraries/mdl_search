#!/bin/bash

# Build the local solr core
git clone https://github.com/UMNLibraries/mdl-solr-core.git;
(cd mdl-solr-core; ./rebuild.sh);

# Build, start the app
mkdir -p public/assets/thumbnails;
docker-compose build;
docker-compose run web rake db:migrate
docker-compose up;