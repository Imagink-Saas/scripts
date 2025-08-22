#!/bin/bash

# Script pour démarrer tous les microservices du projet en ouvrant des terminaux séparés.

echo "🚀 Démarrage de tous les services..."

# Ordre de démarrage pour gérer les dépendances (BDD > Images > IA > Printify > Payment > Frontend)
SERVICES=("bdd-services-MalicknND" "image-service-MalicknND" "service-ia-MalicknND" "printify-service-MalicknND" "payment-services-MalicknND" "front-MalicknND")

# Chemin de base du projet
BASE_PATH=$(pwd)

for service in "${SERVICES[@]}"; do
    echo "-> Démarrage de $service..."
    SERVICE_PATH="$BASE_PATH/$service"
    
    # Vérifier si le répertoire du service existe
    if [ -d "$SERVICE_PATH" ]; then
        # Commande pour ouvrir un nouvel onglet de terminal et y exécuter la commande de démarrage.
        # Le `cd` est crucial pour que `npm run dev` trouve le package.json.
        osascript -e "tell app \"Terminal\" to do script \"cd $SERVICE_PATH && echo '--- Démarrage de $service ---' && npm run dev:infisical\""
    else
        echo "⚠️  Le dossier du service $service est introuvable."
    fi
done

echo "✅ Tous les services ont été lancés dans des terminaux séparés." 