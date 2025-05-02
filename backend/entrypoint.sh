#!/bin/bash

# Pastikan direktori build ada
mkdir -p /var/www/html/public/build

# Create minimal .htaccess in build directory
cat > /var/www/html/public/build/.htaccess << 'EOL'
# Let parent directory handle MIME types and headers
Options -Indexes +FollowSymLinks
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
