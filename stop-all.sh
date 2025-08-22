#!/bin/bash

# Script pour arrêter proprement tous les microservices en se basant sur leurs ports.

echo "🛑 Arrêt de tous les services..."

# Ports utilisés par les services (selon le README)
# Frontend: 3000, IA: 9000, Images: 5002, BDD: 9002
PORTS=(3000 9000 9001 5002 9002 9003 3004)

for port in "${PORTS[@]}"; do
    echo "-> Recherche et arrêt du service sur le port $port..."
    
    # Trouve le PID (Process ID) du processus qui écoute sur le port.
    # L'option -t de lsof ne retourne que le PID, parfait pour `kill`.
    PID=$(lsof -t -i:$port)
    
    if [ -n "$PID" ]; then
        # Tue le processus de manière forcée.
        kill -9 $PID
        echo "   ✅ Service sur le port $port (PID: $PID) a été arrêté."
    else
        echo "   ℹ️ Aucun service trouvé sur le port $port."
    fi
done

# Optionnel: Fermer les fenêtres de terminal créées par start-all.sh
# osascript -e 'tell application "Terminal" to close (every window whose name does not contain "bash")'

echo "✅ Tous les processus des services ont été arrêtés." 