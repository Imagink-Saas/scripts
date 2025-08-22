#!/usr/bin/env bash
set -euo pipefail

# -------------------------------------------------------------------
# Script d'initialisation DB (Supabase + Prisma) avec Infisical intégré
# -------------------------------------------------------------------

# Vérifier que le token Infisical est défini
if [ -z "${INFISICAL_TOKEN:-}" ]; then
  echo "❌ Variable INFISICAL_TOKEN manquante."
  echo "💡 Définis-la avant d'exécuter ce script, ex. :"
  echo "   export INFISICAL_TOKEN=st.6dd1c369-8bd2-4f93-bc7d-b5adeda02aba.3fec49bda5db70e93aa2a7fc68ae6700.6f5ad13e4e8c6999dc9603e0ce99fcda"
  exit 1
fi

# Si on n'est pas déjà dans un contexte Infisical → relancer le script avec infisical run
if [ -z "${DATABASE_URL:-}" ]; then
  echo "🔑 Chargement des secrets avec Infisical..."
  exec infisical run --env=dev --path=/bdd -- "$0" "$@"
fi

echo "🗄️  Configuration de la base de données (Supabase + Prisma)..."

# Vérifier dossier service
if [ ! -d "Bdd-service" ]; then
  echo "❌ Le dossier 'Bdd-service' est introuvable."
  exit 1
fi

cd Bdd-service

# Installer les dépendances
echo "📦 Installation des dépendances npm..."
npm ci

# Générer le client Prisma
echo "🔧 Génération du client Prisma..."
npx prisma generate

# Synchronisation du schéma
echo "📊 Synchronisation du schéma avec Supabase..."
if npx prisma db push --accept-data-loss; then
  echo "✅ Schéma synchronisé avec 'prisma db push'"
else
  echo "⚠️  db push a échoué, tentative avec 'migrate deploy'..."
  npx prisma migrate deploy
fi

# Vérifier la connexion
echo "🔍 Test de connexion à Supabase..."
if echo "SELECT 1;" | npx prisma db execute --stdin --schema prisma/schema.prisma >/dev/null 2>&1; then
  echo "✅ Connexion OK"
else
  echo "❌ Impossible de se connecter à Supabase"
  exit 1
fi

cd ..
echo "🎉 Base configurée avec succès sur Supabase !"
