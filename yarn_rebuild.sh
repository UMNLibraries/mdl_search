sudo rm -rf tmp/cache/assets;
rm -rf node_modules;
docker-compose run web yarn install;
sudo chown -R $(whoami) node_modules
docker-compose stop;
docker-compose up;