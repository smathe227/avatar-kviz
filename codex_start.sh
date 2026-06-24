#!/bin/bash
# ════════════════════════════════════════════
#  🔥 Avatar Kvíz - Codex Launcher
# ════════════════════════════════════════════

DIR="$(cd "$(dirname "$0")" && pwd)"
PORT=8088

# Kill any existing server
kill $(lsof -ti:$PORT 2>/dev/null) 2>/dev/null
kill $(cat /tmp/avatar_server.pid 2>/dev/null) 2>/dev/null

# Start server
cd "$DIR"
setsid python3 server_pwa.py $PORT "$DIR" < /dev/null > /tmp/avatar_server.log 2>&1 &
PID=$!
echo $PID > /tmp/avatar_server.pid
sleep 1

IP=$(hostname -I 2>/dev/null | awk '{print $1}')
[ -z "$IP" ] && IP=$(ip addr show 2>/dev/null | grep "inet " | grep -v "127.0.0.1" | awk '{print $2}' | cut -d/ -f1 | head -1)
[ -z "$IP" ] && IP="localhost"

echo ""
echo "╔═══════════════════════════════════════════╗"
echo "║   🔥 Avatar Kvíz pre deti 🌟             ║"
echo "╠═══════════════════════════════════════════╣"
echo "║                                           ║"
echo "║  📱 V DOMÁCEJ SIETI (rovnaká WiFi):      ║"
echo "║  http://$IP:$PORT/Avatar_Kviz_Deti_v2.html   ║"
echo "║                                           ║"
echo "║  📲 Pre PWA inštaláciu:                  ║"
echo "║  Chrome menu → Pridať na plochu          ║"
echo "║  Ikona: Toruk Makto 🐉                   ║"
echo "║                                           ║"
echo "║  📦 Stav: 2000 otázok, 30/kolo ✅        ║"
echo "║  🎤 Hlasové ovládanie ✅                  ║"
echo "║  🧩 Puzzle odkrývanie ✅                  ║"
echo "║                                           ║"
echo "║  ❌ Zastaviť server:                     ║"
echo "║  kill \$(cat /tmp/avatar_server.pid)      ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

curl -s -o /dev/null -w "  ✅ Server: HTTP %{http_code}\n" http://127.0.0.1:$PORT/Avatar_Kviz_Deti_v2.html
