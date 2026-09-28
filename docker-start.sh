#!/bin/sh
sed -i "s/Listen 80/Listen ${PORT:-80}/" /etc/apache2/ports.conf
sed -i "s/:80>/:${PORT:-80}>/" /etc/apache2/sites-available/000-default.conf

php artisan storage:link || true
php artisan migrate --force || true
php artisan config:cache
php artisan route:cache
php artisan view:cache

apache2-foreground