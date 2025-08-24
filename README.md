# 🚀 TUTORIEL COMPLET — LANCEMENT DU PROJET IMAGINK (Workspace propre)

**Version :** 1.0.0  
**Date :** Juillet 2025  
**Auteur :** Malick Siguy NDIAYE  

---

## 🧭 **STRUCTURE CIBLE**

```
imagink-workspace/
├─ scripts/                 # clone.sh, install-deps.sh, init-db.sh, start-all.sh, stop-all.sh
└─ imagink-project/         # (créé par clone.sh) front, Bdd-service, payment-service, ...
```

**Tous les scripts se lancent depuis `imagink-workspace/` avec `./scripts/<nom>.sh`**

---

## 📋 **PRÉREQUIS**

- **Git**, **Node.js 18+**, **npm**, **Bash/Zsh**
- **WSL (Ubuntu)** si vous êtes sous Windows
- **Accès GitHub** aux dépôts Imagink-Saas
- **Infisical** avec un token (pour injecter DATABASE_URL et autres secrets)

---

## 🚀 **ÉTAPE 1 : CLONER LE REPOSITORY DES SCRIPTS**

```bash
# Créer le workspace propre puis y entrer
mkdir -p ~/imagink-workspace && cd ~/imagink-workspace

# Installer Infisical CLI globalement
npm install -g @infisical/cli

# Vérifier l’installation
infisical --version

# Cloner les scripts (dossier 'scripts/')
git clone https://github.com/Imagink-Saas/scripts.git scripts

# Rendre exécutables
chmod +x scripts/*.sh

# Vérifier
ls -la scripts/
```

**Résultat attendu :**
```
scripts/
  clone.sh
  install-deps.sh
  init-db.sh
  start-all.sh
  stop-all.sh
```

---

## 🚀 **ÉTAPE 2 : CLONER TOUS LES SERVICES (dans imagink-project/)**

```bash
./scripts/clone.sh
```

**Ce que fait `clone.sh` :**
- ✅ crée `imagink-project/` (frère de `scripts/`)
- ✅ clone : `front`, `Bdd-service`, `payment-service`, `ia-service`, `image-service`, `printify-service`, `notifications-service`

**Résultat attendu :**
```
imagink-workspace/
├─ scripts/
└─ imagink-project/
   ├─ front/
   ├─ Bdd-service/
   ├─ payment-service/
   ├─ ia-service/
   ├─ image-service/
   ├─ printify-service/
   └─ notifications-service/
```

---

## 📦 **ÉTAPE 3 : INSTALLER LES DÉPENDANCES DE TOUS LES SERVICES**

```bash
cd imagink-project && ../scripts/install-deps.sh && cd ..
```

**Ce que fait `install-deps.sh` :**
- ✅ entre dans `imagink-project/`
- ✅ exécute `npm ci` dans chaque service
- ✅ s'arrête en cas d'erreur (installation propre et reproductible)

---

## 🗄️ **ÉTAPE 4 : INITIALISER LA BASE DE DONNÉES (Supabase + Prisma via Infisical)**

### **4.1 Exporter le token Infisical (placeholder)**
```bash
export INFISICAL_TOKEN=st.6dd1c369-8bd2-4f93-bc7d-b5adeda02aba.3fec49bda5db70e93aa2a7fc68ae6700.6f5ad13e4e8c6999dc9603e0ce99fcda   
```

### **4.2 Lancer l'init DB**
```bash
cd imagink-project && ../scripts/init-db.sh && cd ..
```

**Le script :**
- ✅ se relance automatiquement via `infisical run` si `DATABASE_URL` n'est pas présent
- ✅ vérifie `imagink-project/Bdd-service/prisma/schema.prisma`
- ✅ `npm ci` + `prisma generate`
- ✅ `prisma db push --accept-data-loss` (dev rapide) ou fallback `prisma migrate deploy`
- ✅ test de connexion SQL via `prisma db execute`

**Sortie attendue :**
```
🗄️  Configuration de la base de données (Supabase + Prisma)...
📦 Installation des dépendances npm...
🔧 Génération du client Prisma...
📊 Synchronisation du schéma avec Supabase...
✅ Schéma synchronisé
🔍 Test de connexion à Supabase...
✅ Connexion OK
🎉 Base configurée avec succès sur Supabase !
```

**Note :** l'option Infisical `--path=/bdd` doit correspondre à votre organisation de secrets (chemin du service).

---

## 🎉 **ÉTAPE 5 : DÉMARRER TOUS LES SERVICES**

```bash
cd imagink-project && ../scripts/start-all.sh && cd ..
```

**Démarre :** BDD → Images → IA → Printify → Payment → Notifications → Front

**Sur macOS :** ouvre des onglets Terminal via `osascript`  
**(Option Linux disponible si besoin)**

**Sortie attendue :**
```
🚀 Démarrage de tous les services...
-> Démarrage de Bdd-service...
-> Démarrage de image-service...
-> Démarrage de ia-service...
-> Démarrage de printify-service...
-> Démarrage de payment-service...
-> Démarrage de notifications-service...
-> Démarrage de front...
✅ Tous les services ont été lancés dans des terminaux séparés.
```

---

## 🔍 **ÉTAPE 6 : VÉRIFICATIONS RAPIDES**

### **Processus & ports**
```bash
ps aux | grep -E "(npm|next|node.*app)" | grep -v grep

lsof -i :3000  # front
lsof -i :9000  # ia-service
lsof -i :9001  # payment-service
lsof -i :9002  # Bdd-service
lsof -i :5002  # image-service
lsof -i :3004  # printify-service
lsof -i :3005  # notifications-service
```

### **Ping HTTP**
```bash
curl -sI http://localhost:3000 | head -n 1
curl -sI http://localhost:9002/health | head -n 1
curl -sI http://localhost:9001/health | head -n 1
```

---

## 🛑 **ÉTAPE 7 : ARRÊTER TOUS LES SERVICES**

```bash
cd imagink-project && ../scripts/stop-all.sh && cd ..
```

**Sortie attendue :**
```
🛑 Arrêt de tous les services Imagink...
🔴 Arrêt des processus Node.js...
✅ Tous les processus ont été arrêtés.
```

---

## 🔧 **COMMANDES UTILES (DÉVELOPPEMENT)**

### **Démarrer un service à la main**
```bash
cd imagink-project/front && npm run dev:infisical
cd imagink-project/Bdd-service && npm run dev:infisical
cd imagink-project/payment-service && npm run dev:infisical
```

### **Prisma Studio**
```bash
cd imagink-project/Bdd-service && npm run db:studio
```

### **Logs / ports**
```bash
ps aux | grep npm
netstat -tlnp | grep -E "(3000|9000|9001|9002|5002|3004|3005)"
```

---

## 🆘 **DÉPANNAGE RAPIDE**

### **Permission denied**
```bash
chmod +x scripts/*.sh
```

### **Port déjà utilisé**
```bash
lsof -i :3000
kill -9 <PID>
```

### **Secrets non injectés (DATABASE_URL manquant)**
```bash
export INFISICAL_TOKEN=st.6dd1c369-8bd2-4f93-bc7d-b5adeda02aba.3fec49bda5db70e93aa2a7fc68ae6700.6f5ad13e4e8c6999dc9603e0ce99fcda
# Test rapide d'injection :
infisical run --env=dev --path=/bdd -- env | grep '^DATABASE_URL='
```

### **DB non accessible / schéma KO**
```bash
./scripts/init-db.sh
```

---

## 📎 **RÉSUMÉ ULTRA-COURT (CHEAT SHEET)**

```bash
# 0) Préparer le workspace
mkdir -p ~/imagink-workspace && cd ~/imagink-workspace
git clone https://github.com/Imagink-Saas/scripts.git scripts
chmod +x scripts/*.sh

# 1) Cloner les services
./scripts/clone.sh

# 2) Installer les dépendances
./scripts/install-deps.sh

# 3) Initialiser la base (via Infisical)
export INFISICAL_TOKEN=st.6dd1c369-8bd2-4f93-bc7d-b5adeda02aba.3fec49bda5db70e93aa2a7fc68ae6700.6f5ad13e4e8c6999dc9603e0ce99fcda
./scripts/init-db.sh

# 4) Démarrer
./scripts/start-all.sh

# 5) Arrêter
./scripts/stop-all.sh
```

---

## 📝 **NOTES OS**

- **macOS :** `start-all.sh` utilise `osascript` pour ouvrir des onglets Terminal
- **Linux :** prévoir une version alternative (`gnome-terminal` / `xterm`)
- **Windows :** utiliser WSL (Ubuntu) pour lancer ces scripts bash

---

## 🌟 **FÉLICITATIONS !**

Votre projet Imagink est maintenant complètement opérationnel dans un workspace propre ! 🎉

### **✅ Structure finale :**
```
imagink-workspace/
├─ scripts/                    # Scripts de gestion
├─ imagink-project/            # Tous les services
│  ├─ front/                  # http://localhost:3000
│  ├─ Bdd-service/            # http://localhost:9002
│  ├─ payment-service/        # http://localhost:9001
│  ├─ ia-service/             # http://localhost:9000
│  ├─ image-service/          # http://localhost:5002
│  ├─ printify-service/       # http://localhost:3004
│  └─ notifications-service/  # http://localhost:3005
└─ TUTORIEL_IMAGINK.md        # Ce fichier
```

### **🌐 Prochaines étapes :**
1. **Ouvrir** http://localhost:3000 dans votre navigateur
2. **Tester** la génération d'images IA
3. **Explorer** l'interface utilisateur
4. **Développer** de nouvelles fonctionnalités

---

**Tutoriel généré le :** Juillet 2025  
**Version :** 1.0.0  
**Statut :** Workspace propre et organisé pour le projet Imagink


