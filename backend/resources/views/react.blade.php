<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Laravel + React</title>

    <!-- Jika menggunakan Laravel Vite plugin -->
    @if (file_exists(public_path('build/manifest.json')))
        <script type="module" src="/build/index.js"></script>
        <link rel="stylesheet" href="/build/index.css">
    @else
        <!-- Fallback jika build tidak ada -->
        <script>console.error('Vite build assets not found');</script>
    @endif
</head>
<body>
    <div id="app"></div>
</body>
</html>
