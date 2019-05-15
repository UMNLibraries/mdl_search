#!/bin/bash

# Build the local solr core
git clone https://github.com/UMNLibraries/mdl-solr-core.git;
(cd mdl-solr-core; ./rebuild.sh);

# Build, start the app
mkdir -p public/assets/thumbnails;
docker-compose build;
docker-compose run web rake db:migrate
docker-compose run db mysql -uroot -ppassword -e "CREATE DATABASE IF NOT EXISTS mdl_test; GRANT ALL PRIVILEGES ON mdl_test.* TO 'mdl'@'%'"
docker-compose run -e "RAILS_ENV=test" web rake db:migrate
docker-compose run web yarn install
sudo chown -R $(whoami) node_modules
docker-compose up;