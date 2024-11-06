FROM php:8.2-fpm

# Install system dependencies and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Create directory structure
RUN mkdir -p var/cache var/log var/sessions public config src templates vendor

# Set permissions
RUN chmod -R 777 var

# Copy composer files first
COPY composer.json ./

# Update dependencies and create a fresh lock file
RUN composer update --no-scripts --no-interaction

# Copy the rest of the application
COPY . .

# Final permission setup
RUN chown -R www-data:www-data .
