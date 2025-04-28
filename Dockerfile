# build frontend using vite
FROM node:18-alpine as build

WORKDIR /app

# copy package.json and package-lock.json
COPY frontend/package*.json ./
RUN npm install

# build frontend 
COPY frontend/ .
RUN npm run build --max-old-space-size=4096

# backend setup
FROM php:8.2-apache

# install dependencies laravel
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libxml2-dev \
    libonig-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    openssl \
    unzip \
    curl \
    git \
    && docker-php-ext-install pdo_mysql zip

# install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# copy apache config
COPY backend/apache.conf /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite \
    && a2enmod headers

#set laravel working directory
WORKDIR /var/www/html

#copy backend files
COPY backend/ ./

# create necessary storage folders
RUN mkdir -p storage/framework/{cache,sessions,views} \
    && mkdir -p storage/logs \
    && chown -R www-data:www-data storage \
    && chmod -R 775 storage

# install laravel dependencies
RUN composer clear-cache \
    && composer install --no-dev --optimize-autoloader --no-scripts --prefer-dist

#build frontend assets
COPY --from=build /app/dist /var/www/html/public/build

#set permissions
RUN mkdir -p /var/www/html/storage /var/www/html/bootstrap/cache \
    && chown -R www-data:www-data /var/www/html /var/www/html/public /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/public /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R o+w /var/www/html/storage

#expose port 80
EXPOSE 80

# start apache server
CMD ["apache2-foreground"]
