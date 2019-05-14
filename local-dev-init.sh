#!/bin/bash

# Build the local solr core
git clone https://github.com/UMNLibraries/mdl-solr-core.git;
(cd mdl-solr-core; ./rebuild.sh);

# Build, start the app
mkdir -p public/assets/thumbnails;
docker-compose build;
docker-compose up;
docker-compose down;
docker-compose run web rake db:migrate
docker-compose exec db mysql -uroot -ppassword -e "CREATE DATABASE IF NOT EXISTS mdl_test; GRANT ALL PRIVILEGES ON mdl_test.* TO 'mdl'@'%'"
docker-compose exec -e "RAILS_ENV=test" web rake db:migrate