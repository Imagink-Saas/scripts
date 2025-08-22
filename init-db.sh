#!/usr/bin/env bash
set -euo pipefail

echo "🗄️  Configuration de la base..."

: "${DATABASE_URL:?DATABASE_URL manquant (via Infisical).}"

if [[ "$DATABASE_URL" == *"supabase.co"* ]]; then
  echo "🔗 Supabase détecté (hébergé) → pas de service local à démarrer."
elif command -v supabase >/dev/null 2>&1 && supabase status >/dev/null 2>&1; then
  echo "🐳 Supabase local (Docker) détecté → pas de systemctl."
elif command -v pg_isready >/dev/null 2>&1; then
  if ! pg_isready >/dev/null 2>&1; then
    echo "⏳ PostgreSQL local non démarré, tentative de démarrage..."
    sudo systemctl start postgresql || true
  fi
fi

cd Bdd-service

echo "🔧 Prisma generate..."
npx prisma generate

# DEV: synchroniser le schéma rapidement (sans migrations)
# npx prisma db push

# PROD/STAGING: appliquer les migrations versionnées
echo "📦 Prisma migrate deploy..."
npx prisma migrate deploy

echo "✅ Base OK"
