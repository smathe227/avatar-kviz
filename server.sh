#!/bin/bash
echo "============================================"
echo "  🔥 Avatar Kvíz pre deti - Server"
echo "============================================"
echo ""
PORT=8088
IP=$(hostname -I 2>/dev/null | awk '{print $1}')
if [ -z "$IP" ]; then IP="127.0.0.1"; fi
echo "  Otvor v mobile/tablete:"
echo "  http://$IP:$PORT/Avatar_Kviz_Deti_v2.html"
echo ""
echo "  Pridaj na plochu: Chrome menu → Pridať na plochu"
echo ""
echo "  Pre ukončenie stlač Ctrl+C"
echo "============================================"
cd "$(dirname "$0")"
python3 server_pwa.py $PORT "$(dirname "$0")"
