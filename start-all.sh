#!/bin/bash

# Script pour démarrer tous les microservices du projet en ouvrant des terminaux séparés (macOS).
# ⚠️ Sous Linux, il faudra remplacer 'osascript' par 'gnome-terminal' ou 'xterm'.

echo "🚀 Démarrage de tous les services..."

# Ordre de démarrage pour gérer les dépendances :
# BDD > Images > IA > Printify > Payment > Notifications > Frontend
SERVICES=("Bdd-service" "image-service" "ia-service" "printify-service" "payment-service" "notifications-service" "front")

# Chemin de base du projet
BASE_PATH=$(pwd)
#!/bin/bash

# Script pour démarrer tous les microservices du projet en ouvrant des terminaux séparés (macOS).
# ⚠️ Sous Linux, il faudra remplacer 'osascript' par 'gnome-terminal' ou 'xterm'.

echo "🚀 Démarrage de tous les services..."

# Ordre de démarrage pour gérer les dépendances :
# BDD > Images > IA > Printify > Payment > Notifications > Frontend
SERVICES=("Bdd-service" "image-service" "ia-service" "printify-service" "payment-service" "notifications-service" "front")

# Chemin de base du projet
BASE_PATH=$(pwd)

for service in "${SERVICES[@]}"; do
    echo "-> Démarrage de $service..."
    SERVICE_PATH="$BASE_PATH/$service"
    
    # Vérifier si le répertoire du service existe
    if [ -d "$SERVICE_PATH" ]; then
        # macOS : ouvre un nouvel onglet Terminal
        osascript -e "tell app \"Terminal\" to do script \"cd $SERVICE_PATH && echo '--- Démarrage de $service ---' && npm run dev:infisical\""
    else
        echo "⚠️  Le dossier du service $service est introuvable."
    fi
done

echo "✅ Tous les services ont été lancés dans des terminaux séparés."

# -------------------------------------------------------------------
# Stripe Webhook Listener (utile en local tant que le projet n'est pas en ligne)
# -------------------------------------------------------------------
echo "⚡ Lancement du listener Stripe pour capturer les webhooks..."
osascript -e "tell app \"Terminal\" to do script \"echo '--- Démarrage du listener Stripe ---' && stripe listen --forward-to localhost:9001/api/webhook/stripe\""
echo "✅ Listener Stripe lancé dans un terminal séparé."

for service in "${SERVICES[@]}"; do
    echo "-> Démarrage de $service..."
    SERVICE_PATH="$BASE_PATH/$service"
    
    # Vérifier si le répertoire du service existe
    if [ -d "$SERVICE_PATH" ]; then
        # macOS : ouvre un nouvel onglet Terminal
        osascript -e "tell app \"Terminal\" to do script \"cd $SERVICE_PATH && echo '--- Démarrage de $service ---' && npm run dev:infisical\""
    else
        echo "⚠️  Le dossier du service $service est introuvable."
    fi
done

echo "✅ Tous les services ont été lancés dans des terminaux séparés."
