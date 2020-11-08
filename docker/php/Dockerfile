FROM php:7.1-fpm

COPY docker/php/php.ini /usr/local/etc/php/conf.d/docker_php_config.ini

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zlib1g-dev \
    libzip-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libicu-dev  \
    libonig-dev \
    libxslt1-dev \
    acl \
    wget \
    mc \
    && apt-get remove --purge --auto-remove -y \
    && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/sury.list \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install pdo pdo_mysql zip xsl gd intl opcache exif mbstring

# install Composer
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer
RUN composer --version

# install Symfony CLI
RUN wget https://get.symfony.com/cli/installer -O - | bash \
    && mv /root/.symfony/bin/symfony /usr/local/bin/symfony \
    && symfony check:requirements \
    && (echo 'alias sf="symfony"'; echo 'alias sfc="bin/console"' ) >> ~/.bashrc

WORKDIR /var/www/html/symfony
