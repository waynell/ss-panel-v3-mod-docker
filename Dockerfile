FROM blepiolot/rpi-apache-php

COPY run.sh /start.sh

RUN apt-get update && apt-get install -y git zip unzip libpng-dev \
    && docker-php-ext-install gd mysqli pdo pdo_mysql \
    && cd /var/www \
    && git clone -b new_master --depth=1 https://github.com/esdeathlove/ss-panel-v3-mod.git html \
    && cd /var/www/html \
    && chmod -R 777 * \
    && cp /var/www/html/config/.config.php.example /var/www/html/config/.config.php \
    && /usr/local/bin/php composer.phar install \
    && /usr/local/bin/php xcat initdownload \
    && /usr/local/bin/php xcat initQQWry \
    && rm -rf /var/www/html/public/ssr-download/.git \
    && rm -rf /tmp/* /var/tmp/* \
    && chmod +x /start.sh \
    && a2enmod rewrite

WORKDIR /var/www/html
EXPOSE 80
