<?php

namespace App\Http\Middleware;

use Closure;

class FixMimeTypes
{
    public function handle($request, Closure $next)
    {
        $response = $next($request);
        $path = $request->path();
        
        if (preg_match('/\.css$/', $path)) {
            $response->header('Content-Type', 'text/css');
        } elseif (preg_match('/\.js$/', $path)) {
            $response->header('Content-Type', 'application/javascript');
        }
        
        return $response;
    }
}