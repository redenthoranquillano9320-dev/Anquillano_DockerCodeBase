FROM devilbox/php-fpm:8.2-work

# Switch to root to install extensions/tools
USER root

# Install required PHP extensions (mysqli/pdo_mysql are already present on most
# devilbox images, but we make sure explicitly + add zip/gd for completeness)
RUN docker-php-ext-install pdo pdo_mysql mysqli || true

# Copy custom php.ini overrides
COPY conf.d/php.ini /usr/local/etc/php/conf.d/custom.ini

WORKDIR /var/www

EXPOSE 9000

CMD ["php-fpm"]
