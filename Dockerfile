FROM php:7-alpine
MAINTAINER jaapio <php-ga@ijaap.nl>

LABEL "com.github.actions.name"="php-ga.composer-require-checker"
LABEL "com.github.actions.description"="composer-require-checker"
LABEL "com.github.actions.icon"="check"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/php-ga/composer-require-checker-ga"
LABEL "homepage"="http://github.com/actions"
LABEL "maintainer"="Jaapio <php-ga@ijaap.nl>"

ENV COMPOSER_HOME /composer
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV PATH /composer/vendor/bin:$PATH

RUN apk --update --progress --no-cache add \
    curl \
    php7-json \
    php7-openssl \
    php7-phar \
    php7-xml \
    php7-zlib \
    && curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
    && curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
    && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { echo 'Invalid installer' . PHP_EOL; exit(1); }" \
    && php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('/tmp/composer-setup.php');" \
    && php -r "unlink('/tmp/composer-setup.sig');" \
    && echo "memory_limit=-1" > /etc/php7/conf.d/99_memory-limit.ini \
    && rm -rf /var/cache/apk/* /var/tmp/* /tmp/* \
    && composer global require maglnet/composer-require-checker

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["composer-require-checker"]
