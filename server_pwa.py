import http.server
import socketserver
import os
import sys

class PWAHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    """HTTP handler with correct MIME types for PWA"""
    
    extensions_map = {
        **http.server.SimpleHTTPRequestHandler.extensions_map,
        '.json': 'application/json',
        '.js': 'application/javascript',
        '.css': 'text/css',
        '.html': 'text/html',
        '.png': 'image/png',
        '.svg': 'image/svg+xml',
        '.webp': 'image/webp',
        '.jpg': 'image/jpeg',
        '.jpeg': 'image/jpeg',
        '.ico': 'image/x-icon',
        '.mht': 'application/octet-stream',
    }
    
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Cache-Control', 'no-cache, must-revalidate')
        super().end_headers()

class ReusableTCPServer(socketserver.TCPServer):
    allow_reuse_address = True

if __name__ == '__main__':
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8080
    directory = sys.argv[2] if len(sys.argv) > 2 else os.getcwd()
    
    os.chdir(directory)
    
    with ReusableTCPServer(('0.0.0.0', port), PWAHTTPRequestHandler) as httpd:
        print(f"🔥 Avatar Kvíz - PWA Server")
        print(f"   Port: {port}")
        print(f"   Directory: {directory}")
        httpd.serve_forever()
