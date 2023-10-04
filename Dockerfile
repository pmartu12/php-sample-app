ARG PHP_VERSION=8.2.10

FROM php:${PHP_VERSION}-fpm-alpine AS php_base

ARG APCU_VERSION=5.1.22
ENV APP_DEBUG=0
ARG GITHUB_TOKEN

USER root

WORKDIR /app

RUN apk add --no-cache \
		autoconf \
        fcgi \
		git \
		g++ \
        icu-dev \
		make \
        libpq-dev \
        icu-dev \
        icu-data-full \
	;

RUN apk update && apk upgrade

RUN set -eux; \
	pecl install \
		apcu-${APCU_VERSION} \
        redis \
        igbinary \
	; \
	pecl clear-cache; \
    docker-php-ext-configure intl \
    ; \
    docker-php-ext-install \
        bcmath \
        intl \
        pdo \
        pdo_pgsql \
        pgsql \
    ;

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER=1

FROM php_base AS php_prod
ARG GITHUB_TOKEN
ENV APP_ENV=env

WORKDIR /app

RUN addgroup -g 3000 -S php && adduser -u 1000 -S php -G php

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint
RUN chmod +x /usr/local/bin/docker-entrypoint

# copy only specifically what we need
COPY .env.preprod ./
COPY bin bin/
COPY config config/
COPY public public/
COPY src src/
COPY template[s] templates/
COPY .build .build/
# This layer is only re-built when dependences files are updated
COPY  composer.json composer.lock symfony.lock ./


RUN touch .env \
  && cp .build/*.ini $PHP_INI_DIR/conf.d/ \
  && mv $PHP_INI_DIR/php.ini-production $PHP_INI_DIR/php.ini \
  && rm -rf /usr/localetc/php-fpm.d \
  && rm  -f /usr/local/etc/php-fpm.conf \
  && cp .build/www.conf /usr/local/etc/php-fpm.conf \
  && mkdir -p var/cache var/log \
  &&  chmod +x bin/console \
  && chown -R php:php .

RUN set -eux; \
  composer install --prefer-dist --no-dev --no-autoloader --no-scripts --no-progress --no-ansi \
  && composer clear-cache --no-ansi \
  && composer dump-autoload --optimize --classmap-authoritative --no-dev \
  && rm -f /root/.composer/auth.json

USER php

ENTRYPOINT ["docker-entrypoint"]

CMD ["php-fpm"]
