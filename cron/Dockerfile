FROM php:7.2-alpine

RUN apk --update add \
  build-base \
  libmemcached-dev \
  libmcrypt-dev \
  libxml2-dev \
  zlib-dev \
  libgsasl-dev

RUN docker-php-ext-install mysqli mbstring pdo pdo_mysql tokenizer xml pcntl

RUN rm /var/cache/apk/* \
    && mkdir -p /var/www

COPY cronfile /etc/cron.d/cronfile

RUN crontab /etc/cron.d/cronfile

CMD crond -f
