#!/bin/bash

# Pastikan direktori build ada
mkdir -p /var/www/html/public/build

# Buat .htaccess di folder build
cat > /var/www/html/public/build/.htaccess << 'EOL'
<IfModule mod_mime.c>
  AddType application/javascript .js
  AddType text/css .css
  AddType image/svg+xml .svg
</IfModule>

<IfModule mod_headers.c>
  <FilesMatch "\.(css|js|svg)$">
    Header set Content-Type "application/javascript" "expr=%{REQUEST_URI} =~ /\.js$/"
    Header set Content-Type "text/css" "expr=%{REQUEST_URI} =~ /\.css$/"
    Header set Content-Type "image/svg+xml" "expr=%{REQUEST_URI} =~ /\.svg$/"
  </FilesMatch>
</IfModule>
EOL

# Set permissions
chmod -R 755 /var/www/html/public/build

# Start Apache
exec apache2-foreground
