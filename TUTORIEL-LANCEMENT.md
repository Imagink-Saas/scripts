# 🚀 TUTORIEL COMPLET - LANCEMENT DU PROJET IMAGINK
## Guide étape par étape pour démarrer tous les micro-services

**Version :** 1.0.0  
**Date :** Juillet 2025  
**Auteur :** Malick Siguy NDIAYE  

---

## 🎯 **OBJECTIF DU TUTORIEL**

Ce tutoriel vous guide pour lancer complètement le projet Imagink en **5 étapes simples** :
1. 📥 Cloner le repository des scripts
2. 🔧 Rendre les scripts exécutables
3. 🚀 Cloner tous les services
4. 📦 Installer les dépendances
5. 🗄️ Initialiser la base de données
6. 🎉 Démarrer tous les services

---

## 📋 **PRÉREQUIS**

### **💻 Logiciels requis**
- **Git** : Pour cloner les repositories
- **Node.js** : Version 18+ LTS
- **npm** : Gestionnaire de paquets Node.js
- **Terminal** : Bash, Zsh, ou PowerShell

### **🔑 Accès requis**
- **GitHub** : Accès aux repositories Imagink-Saas
- **Infisical** : Token configuré pour les variables d'environnement

---

## 🚀 **ÉTAPE 1 : CLONER LE REPOSITORY DES SCRIPTS**

```bash
# Aller dans le dossier où vous voulez installer le projet
cd ~/Desktop  # ou un autre dossier de votre choix

# Cloner le repository des scripts
git clone https://github.com/Imagink-Saas/scripts.git

# Aller dans le dossier des scripts
cd scripts

# Vérifier que les scripts sont présents
ls -la
```

**Résultat attendu :**
```
✅ Repository scripts cloné
📁 Contenu : clone.sh, install-deps.sh, init-db.sh, start-all.sh, stop-all.sh
```

---

## 🔧 **ÉTAPE 2 : RENDRE LES SCRIPTS EXÉCUTABLES**

```bash
# Rendre tous les scripts exécutables
chmod +x *.sh

# Vérifier les permissions
ls -la *.sh
```

**Résultat attendu :**
```
-rwxr-xr-x  1 user  staff   clone.sh
-rwxr-xr-x  1 user  staff   install-deps.sh
-rwxr-xr-x  1 user  staff   init-db.sh
-rwxr-xr-x  1 user  staff   start-all.sh
-rwxr-xr-x  1 user  staff   stop-all.sh
```

---

## 🚀 **ÉTAPE 3 : LANCER LE SCRIPT CLONE.SH**

```bash
# Lancer le script de clonage
./clone.sh
```

**Ce que fait le script :**
- ✅ Crée le dossier `imagink-project`
- ✅ Clone tous les services :
  - `front` (Next.js)
  - `Bdd-service` (Base de données)
  - `payment-service` (Paiements)
  - `ia-service` (Intelligence artificielle)
  - `image-service` (Gestion d'images)
  - `printify-service` (E-commerce)
  - `notifications-service` (Notifications)

**Résultat attendu :**
```
📥 Clonage des repositories Imagink-Saas...
✅ Frontend cloné
✅ Service BDD cloné
✅ Service Payment cloné
✅ Service IA cloné
✅ Service Images cloné
✅ Service Printify cloné
✅ Service Notifications cloné
📁 Structure du projet :
[liste des dossiers]
```

---

## 📦 **ÉTAPE 4 : LANCER LE SCRIPT INSTALL-DEPS**

```bash
# Aller dans le dossier du projet
cd imagink-project

# Lancer l'installation des dépendances
../scripts/install-deps.sh
```

**Ce que fait le script :**
- ✅ Installe les dépendances npm pour chaque service
- ✅ Utilise `npm ci` pour une installation rapide et fiable
- ✅ Traite tous les services séquentiellement

**Résultat attendu :**
```
📦 Installation des dépendances pour tous les services...
⚙️  Installation pour front...
✅ front : OK
⚙️  Installation pour Bdd-service...
✅ Bdd-service : OK
⚙️  Installation pour payment-service...
✅ payment-service : OK
⚙️  Installation pour ia-service...
✅ ia-service : OK
⚙️  Installation pour image-service...
✅ image-service : OK
⚙️  Installation pour printify-service...
✅ printify-service : OK
⚙️  Installation pour notifications-service...
✅ notifications-service : OK
🎉 Toutes les dépendances ont été installées avec succès !
```

---

## 🗄️ **ÉTAPE 5 : INITIALISER LA BASE DE DONNÉES**

```bash
# Configurer le token Infisical
export INFISICAL_TOKEN=st.6dd1c369-8bd2-4f93-bc7d-b5adeda02aba.3fec49bda5db70e93aa2a7fc68ae6700.6f5ad13e4e8c6999dc9603e0ce99fcda

# Lancer l'initialisation de la base de données
infisical run --env=dev --path=/bdd -- ../scripts/init-db.sh
```

**Ce que fait le script :**
- ✅ Vérifie la présence du dossier `Bdd-service`
- ✅ Installe les dépendances du service BDD
- ✅ Génère le client Prisma
- ✅ Synchronise le schéma avec Supabase
- ✅ Teste la connexion à la base de données

**Résultat attendu :**
```
🗄️  Configuration de la base de données (Supabase + Prisma)...
📦 Installation des dépendances npm...
✅ Dépendances installées
🔧 Génération du client Prisma...
✅ Client Prisma généré
📊 Synchronisation du schéma avec Supabase...
✅ Schéma synchronisé avec 'prisma db push'
🔍 Test de connexion à Supabase...
✅ Connexion OK
🎉 Base configurée avec succès sur Supabase !
```

---

## 🎉 **ÉTAPE 6 : DÉMARRER TOUS LES SERVICES**

```bash
# Lancer le démarrage de tous les services
../scripts/start-all.sh
```

**Ce que fait le script :**
- ✅ Démarre tous les services dans des terminaux séparés
- ✅ Respecte l'ordre de dépendances : BDD → Images → IA → Printify → Payment → Frontend
- ✅ Utilise `npm run dev:infisical` pour chaque service

**Résultat attendu :**
```
🚀 Démarrage de tous les services...
-> Démarrage de bdd-services-MalicknND...
-> Démarrage de image-service-MalicknND...
-> Démarrage de service-ia-MalicknND...
-> Démarrage de printify-service-MalicknND...
-> Démarrage de payment-services-MalicknND...
-> Démarrage de front-MalicknND...
✅ Tous les services ont été lancés dans des terminaux séparés.
```

---

## 🌐 **VÉRIFICATION FINALE**

### **📊 Vérifier que tous les services sont actifs**
```bash
# Voir tous les processus Node.js
ps aux | grep -E "(npm|next|node.*app)" | grep -v grep

# Vérifier les ports utilisés
lsof -i :3000  # Frontend
lsof -i :9000  # Service IA
lsof -i :9001  # Service Payment
lsof -i :9002  # Service BDD
lsof -i :5002  # Service Images
lsof -i :3004  # Service Printify
lsof -i :3005  # Service Notifications
```

### **🧪 Tester l'accès aux services**
```bash
# Frontend
curl http://localhost:3000

# Service BDD
curl http://localhost:9002/api/health

# Service Payment
curl http://localhost:9001/api/health
```

---

## 🛑 **ARRÊTER TOUS LES SERVICES**

```bash
# Arrêter tous les services
../scripts/stop-all.sh
```

**Résultat attendu :**
```
🛑 Arrêt de tous les services Imagink...
🔴 Arrêt des processus Node.js...
✅ Tous les processus des services ont été arrêtés.
```

---

## 📝 **COMMANDES RAPIDES POUR LE DÉVELOPPEMENT**

### **🚀 Démarrer un service spécifique**
```bash
# Frontend
cd front && npm run dev:infisical

# Service BDD
cd Bdd-service && npm run dev:infisical

# Service Payment
cd payment-service && npm run dev:infisical
```

### **📊 Ouvrir Prisma Studio**
```bash
cd Bdd-service && npm run db:studio
```

### **🔧 Vérifier les logs**
```bash
# Voir les processus actifs
ps aux | grep npm

# Voir l'utilisation des ports
netstat -tlnp | grep -E "(3000|9000|9001|9002|5002|3004|3005)"
```

---

## ❌ **DÉPANNAGE RAPIDE**

### **Problème : Permission denied**
```bash
chmod +x ../scripts/*.sh
```

### **Problème : Port déjà utilisé**
```bash
# Voir quel processus utilise le port
lsof -i :3000

# Arrêter le processus
kill -9 <PID>
```

### **Problème : Dépendances manquantes**
```bash
# Réinstaller les dépendances
../scripts/install-deps.sh
```

### **Problème : Base de données non accessible**
```bash
# Réinitialiser la base
infisical run --env=dev --path=/bdd -- ../scripts/init-db.sh
```

---

## 🎯 **RÉSUMÉ DES COMMANDES COMPLÈTES**

```bash
# 1. Cloner les scripts
git clone https://github.com/Imagink-Saas/scripts.git
cd scripts

# 2. Rendre exécutables
chmod +x *.sh

# 3. Cloner tous les services
./clone.sh

# 4. Installer les dépendances
cd imagink-project
../scripts/install-deps.sh

# 5. Initialiser la base de données
export INFISICAL_TOKEN=st.6dd1c369-8bd2-4f93-bc7d-b5adeda02aba.3fec49bda5db70e93aa2a7fc68ae6700.6f5ad13e4e8c6999dc9603e0ce99fcda
infisical run --env=dev --path=/bdd -- ../scripts/init-db.sh

# 6. Démarrer tous les services
../scripts/start-all.sh
```

---


