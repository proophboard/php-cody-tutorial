#!/usr/bin/env bash

git clone https://github.com/event-engine/php-iio-cody-tutorial.git exercises

cd exercises
docker-compose run --rm composer install

cd ..

# Install Cody Server
git clone https://github.com/event-engine/php-inspectio-cody.git cody-bot
cd cody-bot
cp .env.dist .env # Adjust UID in .env if needed
cp app.env.dist app.env


sed -i '/app$/a\      - ../exercises:/exercises' docker-compose.yml
sed -i "/^return new CodyConfig/i \$context->path = '/exercises/src';\n" codyconfig.php

docker run --rm -it \
    -v $(pwd):/app \
    prooph/composer:8.0 install

./dev.sh

echo ""
echo "Cody tutorial ready. Visit https://wiki.prooph-board.com/cody/php-cody-tutorial.html"
