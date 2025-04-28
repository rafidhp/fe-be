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

echo "Checking build files..."
ls -la /var/www/html/public/build/

# Jika folder kosong, ada masalah dengan build
if [ -z "$(ls -A /var/www/html/public/build/)" ]; then
  echo "WARNING: Build folder is empty!"
fi

JS_FILE=$(find /var/www/html/public/build -name "*.js" | head -n 1)
CSS_FILE=$(find /var/www/html/public/build -name "*.css" | head -n 1)

if [ -n "$JS_FILE" ]; then
  echo "JS file found: $JS_FILE"
  echo "First 50 characters:"
  head -c 50 "$JS_FILE"
  echo
fi

if [ -n "$CSS_FILE" ]; then
  echo "CSS file found: $CSS_FILE"
  echo "First 50 characters:"
  head -c 50 "$CSS_FILE"
  echo
fi

# Start Apache
exec apache2-foreground
