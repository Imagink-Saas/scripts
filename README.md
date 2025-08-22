# 🚀 GUIDE D'INSTALLATION COMPLET - PROJET IMAGINK
## Installation de tous les micro-services depuis l'organisation GitHub

**Version :** 1.0.0  
**Date :** Décembre 2024  
**Auteur :** MalicknND  
**Organisation GitHub :** [Imagink-Saas](https://github.com/Imagink-Saas)

---

## 📋 **PRÉREQUIS SYSTÈME**

### **💻 Logiciels requis**
- **Node.js** : Version 18+ LTS (recommandé : 20.x)
- **PostgreSQL** : Version 13+ (recommandé : 15.x)
- **npm** : Version 9+ (inclus avec Node.js)
- **Git** : Version 2.30+ pour le clonage
- **tree** : Pour afficher la structure (optionnel)

### **🖥️ Ressources système**
- **RAM** : Minimum 4GB, recommandé 8GB
- **CPU** : 2 cœurs minimum, 4 recommandés
- **Espace disque** : Minimum 5GB pour tous les repositories et dépendances
- **OS** : Linux, macOS, Windows (avec WSL recommandé)

### **🌐 Prérequis réseau**
- **Connexion Internet** : Pour télécharger les dépendances npm
- **GitHub** : Accès aux repositories de l'organisation Imagink-Saas
- **Infisical** : Service de gestion des secrets (gratuit)

### **🔑 Prérequis GitHub**
- **Organisation** : Accès aux repositories Imagink-Saas
- **Permissions** : Clone des repositories privés (si nécessaire)
- **SSH Keys** : Configurées pour l'authentification Git (recommandé)

---

## 🎯 **STRUCTURE DU PROJET**

### **📁 Repositories à cloner**
```
imagink-project/
├── front/                    # Frontend Next.js (TypeScript)
├── Bdd-service/             # Service Base de Données
├── payment-service/         # Service de Paiement
├── ia-service/              # Service IA (Stability AI)
├── image-service/           # Service Images (Supabase)
├── printify-service/        # Service E-commerce (Printify)
├── notifications-service/   # Service Notifications (SMTP/SMS)
└── metrics-service/         # Service Métriques (Monitoring)
```

### **🌐 Ports utilisés par défaut**
- **Frontend** : http://localhost:3000
- **Service IA** : http://localhost:9000
- **Service Payment** : http://localhost:9001
- **Service BDD** : http://localhost:9002
- **Service Images** : http://localhost:5002
- **Service Printify** : http://localhost:3004
- **Service Notifications** : http://localhost:3005
- **Service Métriques** : http://localhost:3006

---

## 🚀 **PROCÉDURE D'INSTALLATION COMPLÈTE**

### **📥 Étape 1 : Clonage des repositories**

```bash
# Créer le dossier principal du projet
mkdir imagink-project && cd imagink-project

# Cloner tous les repositories de l'organisation
echo "📥 Clonage des repositories Imagink-Saas..."

# Frontend (Next.js)
git clone https://github.com/Imagink-Saas/front.git
echo "✅ Frontend cloné"

# Service Base de Données
git clone https://github.com/Imagink-Saas/Bdd-service.git
echo "✅ Service BDD cloné"

# Service de Paiement
git clone https://github.com/Imagink-Saas/payment-service.git
echo "✅ Service Payment cloné"

# Service IA
git clone https://github.com/Imagink-Saas/ia-service.git
echo "✅ Service IA cloné"

# Service Images
git clone https://github.com/Imagink-Saas/image-service.git
echo "✅ Service Images cloné"

# Service Printify
git clone https://github.com/Imagink-Saas/printify-service.git
echo "✅ Service Printify cloné"

# Service Notifications
git clone https://github.com/Imagink-Saas/notifications-service.git
echo "✅ Service Notifications cloné"

# Service Métriques
git clone https://github.com/Imagink-Saas/metrics-service.git
echo "✅ Service Métriques cloné"

# Vérifier la structure
echo "📁 Structure du projet :"
ls -la
```

### **🔧 Étape 2 : Installation d'Infisical CLI**

```bash
# Installer Infisical CLI globalement
echo "🔧 Installation d'Infisical CLI..."
npm install -g @infisical/cli

# Vérifier l'installation
infisical --version
echo "✅ Infisical CLI installé avec succès !"
```

### **📦 Étape 3 : Installation des dépendances**

```bash
# Installer les dépendances pour tous les services
echo "📦 Installation des dépendances pour tous les services..."

# Frontend (Next.js)
echo "🖥️  Installation des dépendances Frontend..."
cd front && npm ci && cd ..
echo "✅ Frontend : dépendances installées"

# Service Base de Données
echo "🗄️  Installation des dépendances BDD..."
cd Bdd-service && npm ci && cd ..
echo "✅ BDD : dépendances installées"

# Service de Paiement
echo "💳 Installation des dépendances Payment..."
cd payment-service && npm ci && cd ..
echo "✅ Payment : dépendances installées"

# Service IA
echo "🤖 Installation des dépendances IA..."
cd ia-service && npm ci && cd ..
echo "✅ IA : dépendances installées"

# Service Images
echo "🖼️  Installation des dépendances Images..."
cd image-service && npm ci && cd ..
echo "✅ Images : dépendances installées"

# Service Printify
echo "🛍️  Installation des dépendances Printify..."
cd printify-service && npm ci && cd ..
echo "✅ Printify : dépendances installées"

# Service Notifications
echo "📧 Installation des dépendances Notifications..."
cd notifications-service && npm ci && cd ..
echo "✅ Notifications : dépendances installées"

# Service Métriques
echo "📊 Installation des dépendances Métriques..."
cd metrics-service && npm ci && cd ..
echo "✅ Métriques : dépendances installées"

echo "🎉 Toutes les dépendances ont été installées avec succès !"
```

### **🗄️ Étape 4 : Configuration de la base de données**

```bash
# Initialiser la base de données PostgreSQL
echo "🗄️  Configuration de la base de données..."

# Vérifier que PostgreSQL est démarré
sudo systemctl status postgresql || sudo systemctl start postgresql

# Aller dans le service BDD
cd Bdd-service

# Générer le client Prisma
echo "🔧 Génération du client Prisma..."
npx prisma generate

# Pousser le schéma vers la base de données
echo "📊 Synchronisation du schéma avec la base..."
npx prisma db push

# Retourner au dossier principal
cd ..

echo "✅ Base de données configurée avec succès !"
```

### **🚀 Étape 5 : Création des scripts de démarrage**

```bash
# Créer le script de démarrage principal
echo "🚀 Création du script de démarrage..."

cat > start-all.sh << 'EOF'
#!/bin/bash
echo "🚀 Démarrage de tous les services Imagink..."
echo "⏳ Veuillez patienter pendant le démarrage..."

# Démarrer le Frontend (Next.js)
echo "🖥️  Démarrage du Frontend..."
cd front && npm run dev:infisical &
cd ..

# Attendre un peu pour éviter les conflits de ports
sleep 2

# Démarrer le Service BDD
echo "🗄️  Démarrage du Service BDD..."
cd Bdd-service && npm run dev:infisical &
cd ..

sleep 2

# Démarrer le Service de Paiement
echo "💳 Démarrage du Service de Paiement..."
cd payment-service && npm run dev:infisical &
cd ..

sleep 2

# Démarrer le Service IA
echo "🤖 Démarrage du Service IA..."
cd ia-service && npm run dev:infisical &
cd ..

sleep 2

# Démarrer le Service Images
echo "🖼️  Démarrage du Service Images..."
cd image-service && npm run dev:infisical &
cd ..

sleep 2

# Démarrer le Service Printify
echo "🛍️  Démarrage du Service Printify..."
cd printify-service && npm run dev:infisical &
cd ..

sleep 2

# Démarrer le Service Notifications
echo "📧 Démarrage du Service Notifications..."
cd notifications-service && npm run dev:infisical &
cd ..

sleep 2

# Démarrer le Service Métriques
echo "📊 Démarrage du Service Métriques..."
cd metrics-service && npm run dev:infisical &
cd ..

echo "✅ Tous les services sont en cours de démarrage..."
echo "📋 Ports utilisés :"
echo "   - Frontend : http://localhost:3000"
echo "   - Service IA : http://localhost:9000"
echo "   - Service Payment : http://localhost:9001"
echo "   - Service BDD : http://localhost:9002"
echo "   - Service Images : http://localhost:5002"
echo "   - Service Printify : http://localhost:3004"
echo "   - Service Notifications : http://localhost:3005"
echo "   - Service Métriques : http://localhost:3006"

# Attendre que tous les services démarrent
echo "⏳ Attente du démarrage complet..."
sleep 10

# Vérifier les processus
echo "🔍 Vérification des processus en cours..."
ps aux | grep -E "(npm|next|node.*app)" | grep -v grep

echo "🎉 Démarrage terminé ! Tous les services devraient être accessibles."
echo "💡 Ouvrez http://localhost:3000 dans votre navigateur pour accéder au frontend."
EOF

# Créer le script d'arrêt
echo "🛑 Création du script d'arrêt..."

cat > stop-all.sh << 'EOF'
#!/bin/bash
echo "🛑 Arrêt de tous les services Imagink..."

# Arrêter tous les processus Node.js
echo "🔴 Arrêt des processus Node.js..."
pkill -f "npm run dev:infisical"
pkill -f "next dev"
pkill -f "node.*app.js"

# Attendre un peu
sleep 3

# Vérifier qu'aucun processus ne reste
echo "🔍 Vérification des processus restants..."
REMAINING=$(ps aux | grep -E "(npm|next|node.*app)" | grep -v grep | wc -l)

if [ $REMAINING -eq 0 ]; then
    echo "✅ Tous les services ont été arrêtés avec succès !"
else
    echo "⚠️  $REMAINING processus restent actifs :"
    ps aux | grep -E "(npm|next|node.*app)" | grep -v grep
    echo "💡 Utilisez 'kill -9 <PID>' pour forcer l'arrêt si nécessaire."
fi
EOF

# Rendre les scripts exécutables
chmod +x start-all.sh stop-all.sh

echo "✅ Scripts de démarrage et d'arrêt créés !"
```

### **🎯 Étape 6 : Démarrage des services**

```bash
# Démarrer tous les services
echo "🚀 Démarrage de tous les services..."
./start-all.sh

echo "⏳ Attendez que tous les services démarrent..."
echo "💡 Vous pouvez vérifier les processus avec : ps aux | grep npm"
```

---

## 🔍 **VÉRIFICATION DE L'INSTALLATION**

### **📊 Vérification des services**

```bash
# Vérifier que tous les repositories sont présents
echo "📁 Vérification de la structure du projet :"
ls -la

# Vérifier les processus en cours
echo "🔍 Vérification des processus actifs :"
ps aux | grep -E "(npm|next|node.*app)" | grep -v grep

# Vérifier les ports utilisés
echo "🌐 Vérification des ports utilisés :"
echo "Frontend (3000):"
lsof -i :3000 2>/dev/null || echo "   ❌ Port 3000 non utilisé"
echo "Service IA (9000):"
lsof -i :9000 2>/dev/null || echo "   ❌ Port 9000 non utilisé"
echo "Service Payment (9001):"
lsof -i :9001 2>/dev/null || echo "   ❌ Port 9001 non utilisé"
echo "Service BDD (9002):"
lsof -i :9002 2>/dev/null || echo "   ❌ Port 9002 non utilisé"
```

### **🌐 Test d'accès aux services**

```bash
# Tester l'accès au frontend
echo "🧪 Test d'accès au frontend..."
curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 && echo " - Frontend accessible" || echo " - Frontend non accessible"

# Tester l'accès au service BDD
echo "🧪 Test d'accès au service BDD..."
curl -s -o /dev/null -w "%{http_code}" http://localhost:9002/health 2>/dev/null && echo " - Service BDD accessible" || echo " - Service BDD non accessible"

# Tester l'accès au service Payment
echo "🧪 Test d'accès au service Payment..."
curl -s -o /dev/null -w "%{http_code}" http://localhost:9001/health 2>/dev/null && echo " - Service Payment accessible" || echo " - Service Payment non accessible"
```

---

## 🛠️ **DÉPANNAGE DES PROBLÈMES COURANTS**

### **❌ Problème : Permission denied sur les scripts**
```bash
# Solution : Rendre les scripts exécutables
chmod +x *.sh
```

### **❌ Problème : Port déjà utilisé**
```bash
# Vérifier quel processus utilise le port
lsof -i :3000

# Arrêter le processus
kill -9 <PID>
```

### **❌ Problème : Dépendances manquantes**
```bash
# Nettoyer le cache npm
npm cache clean --force

# Supprimer node_modules et réinstaller
cd <service-name>
rm -rf node_modules package-lock.json
npm install
cd ..
```

### **❌ Problème : Base de données non accessible**
```bash
# Vérifier le statut de PostgreSQL
sudo systemctl status postgresql

# Démarrer PostgreSQL
sudo systemctl start postgresql

# Vérifier la connexion
psql -U postgres -h localhost
```

### **❌ Problème : Service ne démarre pas**
```bash
# Vérifier les logs du service
cd <service-name>
npm run dev:infisical

# Vérifier les variables d'environnement
infisical secrets ls --env=dev --path=/<service-path>
```

---

## 🎯 **COMMANDES UTILES POUR LE DÉVELOPPEMENT**

### **🚀 Démarrer un service spécifique**
```bash
# Frontend
cd front && npm run dev:infisical

# Service BDD
cd Bdd-service && npm run dev:infisical

# Service Payment
cd payment-service && npm run dev:infisical

# Service IA
cd ia-service && npm run dev:infisical

# Service Images
cd image-service && npm run dev:infisical

# Service Printify
cd printify-service && npm run dev:infisical

# Service Notifications
cd notifications-service && npm run dev:infisical

# Service Métriques
cd metrics-service && npm run dev:infisical
```

### **📊 Monitoring des services**
```bash
# Voir tous les processus
ps aux | grep -E "(npm|next|node.*app)" | grep -v grep

# Voir l'utilisation des ports
netstat -tlnp | grep -E "(3000|9000|9001|9002|5002|3004|3005|3006)"

# Voir les logs en temps réel (si disponibles)
tail -f */logs/*.log 2>/dev/null || echo "Aucun fichier de log trouvé"
```

### **🔧 Maintenance des services**
```bash
# Redémarrer un service spécifique
pkill -f "front.*dev:infisical" && cd front && npm run dev:infisical

# Mettre à jour les dépendances d'un service
cd <service-name> && npm update && cd ..

# Vérifier les vulnérabilités
cd <service-name> && npm audit && cd ..
```

---

## 📝 **NOTES IMPORTANTES**

### **🔐 Variables d'environnement**
- **Tous les tokens Infisical sont pré-configurés** dans les scripts npm
- **Chaque service a ses propres variables** dans Infisical
- **Aucun fichier .env** n'est nécessaire

### **🌐 Accès aux services**
- **Frontend** : http://localhost:3000 (interface utilisateur)
- **API Services** : Ports 9000-9002, 5002, 3004-3006
- **Base de données** : PostgreSQL sur port 5432

### **📁 Structure des repositories**
- **Chaque service est un repository séparé**
- **Pas de monorepo** - architecture micro-services pure
- **Dépendances gérées individuellement** par service

### **🚀 Démarrage automatique**
- **Script start-all.sh** : Démarre tous les services
- **Script stop-all.sh** : Arrête tous les services
- **Démarrage séquentiel** pour éviter les conflits de ports

---

## 🎉 **FÉLICITATIONS !**

Votre projet Imagink est maintenant complètement installé et configuré ! 

### **✅ Ce qui a été installé :**
- **8 micro-services** opérationnels
- **Frontend Next.js** moderne et responsive
- **Base de données PostgreSQL** avec Prisma
- **Scripts de gestion** automatiques
- **Configuration Infisical** complète

