#!/bin/sh
set -e

if [ "$APP_ENV" = 'preprod' ]
then
  rm -f .env.prod
elif [ "$APP_ENV" = 'prod' ]
then
  rm -f .env.preprod
fi
composer dump-env "$APP_ENV"
composer run-script --no-dev --no-ansi post-install-cmd
bin/console cache:clear
composer clear-cache --no-ansi
sync

exec docker-php-entrypoint "$@"