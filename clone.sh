#!/bin/bash
set -euo pipefail

# Script pour cloner tous les repositories du projet Imagink-Saas

# Créer le dossier principal du projet s'il n'existe pas
mkdir -p imagink-project
cd imagink-project

# Cloner tous les repositories de l'organisation
echo "📥 Clonage des repositories Imagink-Saas..."

# Frontend (Next.js)
if [ ! -d "front" ]; then
  git clone https://github.com/Imagink-Saas/front.git
  echo "✅ Frontend cloné"
else
  echo "ℹ️  Le dossier 'front' existe déjà, clonage ignoré."
fi

# Service Base de Données
if [ ! -d "Bdd-service" ]; then
  git clone https://github.com/Imagink-Saas/Bdd-service.git
  echo "✅ Service BDD cloné"
else
  echo "ℹ️  Le dossier 'Bdd-service' existe déjà, clonage ignoré."
fi

# Service de Paiement
if [ ! -d "payment-service" ]; then
  git clone https://github.com/Imagink-Saas/payment-service.git
  echo "✅ Service Payment cloné"
else
  echo "ℹ️  Le dossier 'payment-service' existe déjà, clonage ignoré."
fi

# Service IA
if [ ! -d "ia-service" ]; then
  git clone https://github.com/Imagink-Saas/ia-service.git
  echo "✅ Service IA cloné"
else
  echo "ℹ️  Le dossier 'ia-service' existe déjà, clonage ignoré."
fi

# Service Images
if [ ! -d "image-service" ]; then
  git clone https://github.com/Imagink-Saas/image-service.git
  echo "✅ Service Images cloné"
else
  echo "ℹ️  Le dossier 'image-service' existe déjà, clonage ignoré."
fi

# Service Printify
if [ ! -d "printify-service" ]; then
  git clone https://github.com/Imagink-Saas/printify-service.git
  echo "✅ Service Printify cloné"
else
  echo "ℹ️  Le dossier 'printify-service' existe déjà, clonage ignoré."
fi

# Service Notifications
if [ ! -d "notifications-service" ]; then
  git clone https://github.com/Imagink-Saas/notifications-service.git
  echo "✅ Service Notifications cloné"
else
  echo "ℹ️  Le dossier 'notifications-service' existe déjà, clonage ignoré."
fi

# Vérifier la structure finale
echo "📁 Structure du projet :"
ls -la
