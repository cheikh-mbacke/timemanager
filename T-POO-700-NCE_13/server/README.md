# Time Manager

Cette API est construite avec Phoenix Framework et utilise PostgreSQL comme base de données. Suivez les étapes ci-dessous pour configurer et lancer l'API localement.

## Prérequis

  * Assurez-vous d'avoir [`Elixir`](`https://elixir-lang.org/install.html`) et [`Phoenix`](`https://hexdocs.pm/phoenix/installation.html`) installés sur votre machine.
  * Vous devez aussi avoir [`PostgreSQL`](https://www.postgresql.org/download/) installé et en cours d'exécution.
  * Avoir un fichier `.env` à la racine du répertoire `server` avec les variables d'environnement nécessaires. Un exemple est fourni ci-dessous.

## Étapes d'installation

  * Clonez le dépôt: `git clone https://github.com/EpitechMscProPromo2025/T-POO-700-NCE_13.git`
  * Déplacz-vous dans le dossier du projet `cd T-POO-700-NCE_13`
  
  * **Configuration des variables d'environnement** :
    - Copiez le contenu suivant dans un fichier `.env` à la racine du projet :
      ```
      export DATABASE_USER="mon_utilisateur"
      export DATABASE_PASSWORD="ton_mot_de_passe"
      ```
    - Mettez à jour les valeurs `DATABASE_USER` et `DATABASE_PASSWORD` avec vos identifiants PostgreSQL.

  * Installez les dépendances: `mix setup`
  * Créez et migrez la base de données. Assurez-vous d'avoir démarré votre serveur PostgreSQL. Puis exécutez ces deux commandes: `mix ecto.create` et `mix ecto.migrate`
  * Lancez le serveur Phoenix : `mix phx.server`

L'adresse du serveur : [`localhost:4000`](http://localhost:4000).
