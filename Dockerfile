FROM php:8.2-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    git unzip curl libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libzip-dev zip chromium chromium-driver \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Install Node.js & NPM
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

WORKDIR /var/www/html

# Install Laravel ke container
RUN composer create-project laravel/laravel .

# Copy file tambahan
COPY app/Http/Controllers/ /var/www/html/app/Http/Controllers/
COPY routes/web.php /var/www/html/routes/web.php
COPY resources/views/ /var/www/html/resources/views/
COPY public/css/ /var/www/html/public/css/
COPY public/js/ /var/www/html/public/js/

RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

CMD ["php-fpm"]
