#!/bin/bash
set -e

echo "📦 Installation des dépendances pour tous les services..."

services=(
  "front"
  "Bdd-service"
  "payment-service"
  "ia-service"
  "image-service"
  "printify-service"
  "notifications-service"
)

for svc in "${services[@]}"; do
  echo "⚙️  Installation pour $svc..."
  cd "$svc" && npm ci && cd ..
  echo "✅ $svc : OK"
done

echo "🎉 Toutes les dépendances ont été installées avec succès !"
