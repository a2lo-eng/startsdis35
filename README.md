# MONSTART 35 — version personnelle multi-comptes

Application web progressive (PWA) en français, conçue pour iPhone et PC. Elle comprend une connexion par e-mail/mot de passe, un planning personnel, un calendrier, des fiches de suivi de véhicules, un profil, l'export JSON et une demande de permission de notifications navigateur.

## Important : configuration requise avant la première connexion

Cette archive n'est pas reliée à un serveur et ne contient aucun compte prêt à l'emploi. Pour que la connexion et la synchronisation fonctionnent, il faut configurer gratuitement un projet Supabase et y exécuter le schéma SQL ci-joint. L'application n'a pas été testée en production ni auditée par un expert en sécurité.

### 1. Créer le backend gratuit

1. Crée un compte sur https://supabase.com/ et un projet.
2. Dans le tableau de bord du projet, ouvre **SQL Editor**, crée une requête et colle le contenu de `supabase-schema.sql`, puis exécute-la.
3. Dans **Project Settings / API** (ou **Connect** selon l'interface), copie l'URL du projet et la clé publique `anon` / publishable. Ne copie jamais `service_role` / secret dans le site.
4. Ouvre `app.js` avec un éditeur de texte. Remplace `COLLEZ_ICI_URL_SUPABASE` et `COLLEZ_ICI_CLE_ANON_PUBLIQUE` par ces deux valeurs.
5. Dans les réglages Authentication de Supabase, garde la confirmation e-mail activée si possible et configure les URL autorisées pour ton futur site GitHub Pages (Site URL et Redirect URLs). Pour les essais locaux, utilise un serveur local et ajoute son URL dans Redirect URLs si nécessaire.

### 2. Publier gratuitement sur GitHub Pages

1. Crée un dépôt GitHub **Public** nommé `monstart35`.
2. Envoie les fichiers de cette archive décompressée à la racine du dépôt (pas l'archive ZIP).
3. Ouvre **Settings → Pages**, sélectionne `Deploy from a branch`, branche `main`, dossier `/(root)`, puis enregistre.
4. Attends la publication. Configure l'URL `https://TON-PSEUDO.github.io/monstart35/` dans les URL autorisées Supabase.
5. Ouvre le site en HTTPS sur l'iPhone dans Safari, puis **Partager → Sur l'écran d'accueil**.

## Comptes et confidentialité

- Chaque personne crée son propre compte avec une adresse e-mail et un mot de passe d'au moins 8 caractères.
- Le schéma active la sécurité au niveau des lignes (RLS) et chaque ligne est associée à `auth.uid()`. Les utilisateurs ne peuvent lire/modifier que leur profil, leur planning et leurs fiches de véhicules. Ce n'est pas un système de gestion de flotte partagée ni un rôle administrateur.
- Ne partage jamais ton mot de passe. Ne publie jamais la clé `service_role`. Ne stocke pas de données opérationnelles, d'identités de victimes, d'adresses d'intervention, de codes d'accès, ou d'informations confidentielles SDIS.
- Utilise uniquement des données personnelles/de démonstration. Le logo SDIS 35 n'est pas inclus : il faut avoir le droit d'utiliser un fichier officiel.

## Limites

- Les notifications navigateur nécessitent une permission. Les notifications planifiées quand le site est fermé ne sont pas garanties : elles demandent un service de notifications/push séparé et une configuration supplémentaire. Cette version ne déclenche pas de notifications opérationnelles.
- GitHub Pages héberge des fichiers statiques : l'authentification et les données passent par Supabase.
- Les fiches de véhicules sont un suivi personnel non officiel et ne reflètent pas l'état réel des véhicules du SDIS.
- Avant un usage réel par plusieurs personnes, faire contrôler la configuration, la sécurité, la politique de confidentialité et les conditions d'utilisation par un responsable autorisé.
