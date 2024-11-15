FROM php:7.4-apache

# Install PHP extensions needed for MySQL
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable mod_rewrite for Apache (if needed for URLs in PHP)
RUN a2enmod rewrite

# Copy all files from the current directory to the Apache container's public directory
COPY . /var/www/html/

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html/

# Expose the Apache port
EXPOSE 80

# Optional: Copy custom Apache configuration if needed
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf

RUN apache2ctl restart

CMD ["apache2ctl", "-D", "FOREGROUND"]
