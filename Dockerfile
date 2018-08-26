FROM blepiolot/rpi-apache-php

COPY run.sh /start.sh

RUN apt-get update && apt-get install -y git zip unzip libpng-dev \
    && docker-php-ext-install gd \
    && rm -rf /data/www \
    && mkdir /data/www \
    && cd /data \
    && git clone -b new_master --depth=1 https://github.com/esdeathlove/ss-panel-v3-mod.git www \
    && cd /data/www \
    && chmod -R 777 * \
    && cp /data/www/config/.config.php.example /data/www/config/.config.php \
    && /usr/local/bin/php composer.phar install \
    && /usr/local/bin/php xcat initdownload \
    && /usr/local/bin/php xcat initQQWry \
    && rm -rf /data/www/public/ssr-download/.git \
    && rm -rf /tmp/* /var/tmp/* \
    && chmod +x /start.sh \
    && a2enmod rewrite

WORKDIR /data/www
EXPOSE 80
