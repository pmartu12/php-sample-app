ARG VIRTUAL_REGISTRY=docker.io
ARG PHP_VERSION=8.2.10

FROM ${VIRTUAL_REGISTRY}/php:${PHP_VERSION}-fpm-alpine

ARG PHPSTAN_VERSION=1.10.35
ARG PHPSTAN_SYMFONY_VERSION=1.3.2
ARG DOCTRINE_CODING_STANDARD_VERSION=12.0.0
ARG SAFE_RULE_VERSION=1.2.0
ARG STRICT_RULE_VERSION=1.0.0
ARG SAFE_VERSION=2.5.0

RUN apk add --no-cache autoconf make g++ unzip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /usr/local/bin/composer

ENV COMPOSER_ALLOW_SUPERUSER=1

RUN composer global config --no-plugins allow-plugins.dealerdirect/phpcodesniffer-composer-installer true
RUN composer global require "phpstan/phpstan:${PHPSTAN_VERSION}" --no-interaction --prefer-dist --no-progress --classmap-authoritative
RUN composer global require "doctrine/coding-standard:${DOCTRINE_CODING_STANDARD_VERSION}" --no-interaction --prefer-dist --no-progress --classmap-authoritative
RUN composer global require "phpstan/phpstan-symfony:${PHPSTAN_SYMFONY_VERSION}" --no-interaction --prefer-dist --no-progress --classmap-authoritative
RUN composer global require "thecodingmachine/safe:${SAFE_VERSION}" --no-interaction --prefer-dist --no-progress --classmap-authoritative
RUN composer global require "thecodingmachine/phpstan-safe-rule:${SAFE_RULE_VERSION}" --no-interaction --prefer-dist --no-progress --classmap-authoritative
RUN composer global require "thecodingmachine/phpstan-strict-rules:${STRICT_RULE_VERSION}" --no-interaction --prefer-dist --no-progress --classmap-authoritative
ENV PATH="/root/.composer/vendor/bin":${PATH}

WORKDIR /app
USER root

