ARG VIRTUAL_REGISTRY=docker.io
ARG PHP_VERSION=8.2.10

FROM ${VIRTUAL_REGISTRY}/php:${PHP_VERSION}-fpm-alpine

ARG PHPCS_VERSION=3.7.2
ARG PHPCODINGSTANDARD_VERSION=8.13.4
ARG DOCTRINE_CODING_STANDARD_VERSION=12.0.0

RUN apk add --no-cache autoconf make g++

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN composer global config --no-plugins allow-plugins.dealerdirect/phpcodesniffer-composer-installer true
RUN composer global require slevomat/coding-standard:${PHPCODINGSTANDARD_VERSION} --no-interaction --prefer-dist --no-progress --classmap-authoritative
RUN composer global require squizlabs/php_codesniffer:${PHPCS_VERSION} --no-interaction --prefer-dist --no-progress --classmap-authoritative
RUN composer global require doctrine/coding-standard:${DOCTRINE_CODING_STANDARD_VERSION} --no-interaction --prefer-dist --no-progress --classmap-authoritative
ENV PATH="/root/.composer/vendor/bin":${PATH}
RUN composer global clearcache && composer global install


WORKDIR /app
USER root
