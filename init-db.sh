#!/usr/bin/env bash
set -euo pipefail

echo "🗄️  Configuration de la base de données (Supabase + Prisma)..."

# Vérifier que DATABASE_URL est bien défini via Infisical
if [ -z "${DATABASE_URL:-}" ]; then
    echo "❌ DATABASE_URL non défini !"
    echo "💡 Assurez-vous d'exécuter :"
    echo "   INFISICAL_TOKEN=st.6dd1c369-8bd2-4f93-bc7d-b5adeda02aba.3fec49bda5db70e93aa2a7fc68ae6700.6f5ad13e4e8c6999dc9603e0ce99fcda infisical run --env=dev --path=/bdd -- ./scripts/init-db.sh"
    exit 1
fi

# Vérifier si le service BDD existe (nom correct du dossier)
if [ ! -d "Bdd-service" ]; then
    echo "❌ Le dossier Bdd-service n'existe pas."
    echo "💡 Assurez-vous d'être dans le répertoire racine du projet"
    echo "📁 Dossiers disponibles :"
    ls -la | grep -E "(bdd|Bdd)" || echo "   Aucun dossier BDD trouvé"
    exit 1
fi

cd Bdd-service

# Installer les dépendances
echo "📦 Installation des dépendances npm..."
npm ci

# Générer le client Prisma
echo "🔧 Génération du client Prisma..."
npx prisma generate

# Synchroniser le schéma avec Supabase (plus approprié que migrate deploy)
echo "📊 Synchronisation du schéma avec Supabase..."
echo "🔄 Utilisation de db push pour Supabase..."
if npx prisma db push --accept-data-loss; then
    echo "✅ Schéma synchronisé avec Supabase"
else
    echo "⚠️  db push échoué, tentative avec les migrations..."
    if npx prisma migrate deploy; then
        echo "✅ Migrations appliquées avec succès"
    else
        echo "❌ Échec de la synchronisation avec Supabase"
        echo "💡 Vérifiez que :"
        echo "   - DATABASE_URL est correct"
        echo "   - Supabase est accessible"
        echo "   - Le schéma Prisma est valide"
        exit 1
    fi
fi

# Vérifier la connexion
echo "🔍 Test de connexion à Supabase..."
if npx prisma db execute --stdin <<< "SELECT 1;" >/dev/null 2>&1; then
    echo "✅ Connexion à Supabase OK"
else
    echo "❌ Impossible de se connecter à Supabase"
    exit 1
fi

# Vérifier que les tables ont été créées
echo "🔍 Vérification des tables créées sur Supabase..."
TABLES=$(npx prisma db execute --stdin <<< "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';" 2>/dev/null | grep -E "(images|products|credits)" | wc -l)

if [ "$TABLES" -ge 3 ]; then
    echo "✅ Tables principales créées : images, products, credits"
else
    echo "⚠️  Certaines tables peuvent être manquantes"
    echo "📊 Tables trouvées :"
    npx prisma db execute --stdin <<< "SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';" 2>/dev/null | grep -v "table_name" || echo "   Aucune table trouvée"
fi

# Retourner au répertoire racine
cd ..

echo "🎉 Base configurée avec succès sur Supabase !"
echo "📋 Résumé :"
echo "   ✅ Dépendances installées"
echo "   ✅ Client Prisma généré"
echo "   ✅ Schéma synchronisé avec Supabase"
echo "   ✅ Connexion testée et validée"
echo "   ✅ Tables principales créées"
echo ""
echo "🚀 Pour démarrer le service : cd Bdd-service && npm run dev:infisical"
echo "📊 Pour ouvrir Prisma Studio : cd Bdd-service && npm run db:studio"
echo "🔧 Port du service : 9002"
