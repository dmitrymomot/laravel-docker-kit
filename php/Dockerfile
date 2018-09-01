FROM php:7.2-fpm

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    curl \
    libmemcached-dev \
    libgd-dev \
    libz-dev \
    libpq-dev \ 
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libssl-dev \
    libmcrypt-dev

RUN apt-get install libzip-dev -y && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install zip

RUN apt-get update \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
    bcmath \
    pdo_mysql \
    gd

RUN docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache

RUN curl -s -f -L -o /tmp/installer.php https://getcomposer.org/installer \
    && php /tmp/installer.php --no-ansi --install-dir=/usr/bin --filename=composer \
    && rm /tmp/installer.php \
    && composer --ansi --version  --no-interaction

RUN echo "alias phpunit='php /var/www/vendor/bin/phpunit'" >> /root/.bashrc
RUN echo "alias artisan='php /var/www/artisan'" >> /root/.bashrc

USER root

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog

RUN usermod -u 1000 www-data

WORKDIR /var/www

CMD ["php-fpm"]

EXPOSE 9000
