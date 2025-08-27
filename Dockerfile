FROM php:8.2-fpm

# OS deps + PHP ext + Chromium (untuk PDF)
RUN apt-get update && apt-get install -y \
    git unzip curl libpng-dev libjpeg-dev libfreetype6-dev \
    libonig-dev libzip-dev zip chromium chromium-driver \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip

# Composer
COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

# Node (opsional buat asset build)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

WORKDIR /var/www/html

# 1) Install Laravel fresh ke image
RUN composer create-project laravel/laravel .

# 2) Siapkan .env + SESSION_DRIVER=file + APP_KEY
RUN cp .env.example .env \
 && sed -i 's/^SESSION_DRIVER=.*/SESSION_DRIVER=file/' .env || echo "SESSION_DRIVER=file" >> .env \
 && php artisan key:generate --no-interaction

# 3) Copy kode custom (controller/routes/views/assets) dari repo ke image
#    (biarkan baris-baris ini kalau Anda memang meletakkan file-file ini di repo)
COPY app/Http/Controllers/ /var/www/html/app/Http/Controllers/
COPY routes/web.php            /var/www/html/routes/web.php
COPY resources/views/          /var/www/html/resources/views/
COPY public/css/               /var/www/html/public/css/
COPY public/js/                /var/www/html/public/js/

# 4) Pastikan storage & cache siap dan writable
RUN mkdir -p storage/framework/sessions storage/framework/views storage/framework/cache bootstrap/cache \
 && chown -R www-data:www-data storage bootstrap/cache

# (opsional) pastikan config tidak tercache dengan setting lama
RUN php artisan config:clear || true

CMD ["php-fpm"]
