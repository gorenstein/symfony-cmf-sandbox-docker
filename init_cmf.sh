#############################
## clear existing data if any

docker-compose rm --stop --force -v # remove container if any
docker volume rm symfony-cmf-sandbox-docker_db_data # remove database volume if any
# remove cmf source if any
sudo rm -f symfony/*
sudo rm -rf symfony/.* &>/dev/null

#######
## init

# build & start containers
docker-compose build
docker-compose up -d

# Downloading the Symfony CMF Sandbox
docker-compose exec php composer create-project --no-scripts symfony-cmf/sandbox /var/www/html/symfony

# copy default settings
sudo chown -R $USER:$USER symfony
cp symfony/app/config/phpcr_doctrine_dbal.yml.dist symfony/app/config/phpcr.yml
cp -R cmf_default/* symfony/

# install dependencies & assets
docker-compose exec php composer install --working-dir=/var/www/html/symfony
sudo chown -R $USER:$USER symfony
sudo chmod -R 777 symfony/var

# init database & fixtures
docker-compose exec php bin/console doctrine:phpcr:init:dbal --force
docker-compose exec php bin/console doctrine:phpcr:repository:init
docker-compose exec php bin/console doctrine:phpcr:fixtures:load -n

# create unit test
docker-compose exec php bin/console doctrine:phpcr:workspace:create sandbox_test

####################################################
## done
echo
echo '============================================='
echo ' Done'
echo '============================================='
echo '   localhost:8080 - CMF UI';
echo '   localhost:8081 - phpmyadmin root/hello'
echo '---------------------------------------------'
echo