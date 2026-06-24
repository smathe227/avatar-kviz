#!/bin/bash
cd "$(dirname "$0")"
echo "Spúšťam Avatar Kvíz server na porte 8088..."
python3 server_pwa.py 8088 "$(pwd)"
