# Design Document

By Meriam Chebbi


## Scope

In this section you should answer the following questions:

* What is the purpose of your database?

************************************************

L’objectif de ma base de données est de représenter un système inspiré d’IMDb, capable de stocker et d’organiser des informations sur des films, des séries, leurs saisons et épisodes, ainsi que les acteurs, réalisateurs, genres et notes attribuées par les utilisateurs.
L’idée est de :
- 	afficher la distribution d’un film,
- 	consulter tous les épisodes d’une série,
- 	trouver les films les mieux notés,
- 	voir la filmographie d’un acteur,
-	identifier les réalisateurs d’un film

**************************************************

* Which people, places, things, etc. are you including in the scope of your database?

***************************************************
les films
les séries
les saisons et épisodes
les acteurs et réalisateurs
les genres
les utilisateurs
les notes
les relations de casting (qui joue dans quoi)

***************************************************

* Which people, places, things, etc. are *outside* the scope of your database?

***************************************************
les plateformes de streaming,
les budgets ou recettes,
les récompenses (Oscars, etc.),
les critiques textuelles,
les fichiers multimédias (bandes‑annonces, images).

***************************************************

## Functional Requirements

In this section you should answer the following questions:

* What should a user be able to do with your database?

***************************************************
ajouter des films, séries, saisons et épisodes
enregistrer des acteurs et des réalisateurs
associer des genres à des films
indiquer quels acteurs jouent dans quels films ou épisodes
attribuer des notes aux films
voir :
-le top des films les mieux notés,
-la liste des épisodes d’une série,
-les films réalisés par une personne,
-les rôles joués par un acteur,
-les films d’un genre particulier.

***************************************************

* What's beyond the scope of what a user should be able to do with your database?

***************************************************
L’utilisateur ne pourra pas :
-uploader des vidéos ou images,
-écrire des critiques textuelles,
-gérer des comptes avec mots de passe,
-suivre la disponibilité des films sur les plateformes,
-consulter des données financières.

***************************************************

## Representation

### Entities

In this section you should answer the following questions:

* Which entities will you choose to represent in your database?
* What attributes will those entities have?
* Why did you choose the types you did?
* Why did you choose the constraints you did?

***************************************************
-Films
Attributs : id, title, release_year, duration, description
J’ai choisi ces attributs car ils représentent les informations essentielles d’un film. La durée est stockée en minutes pour simplifier.

-Séries
Attributs : id, title, start_year, end_year
L’année de fin peut être NULL si la série est toujours en cours.

-Saisons
Attributs : id, series_id, season_number
Une série peut avoir plusieurs saisons, ce qui justifie une relation 1‑N.

-Épisodes
Attributs : id, season_id, episode_number, title, duration
Chaque saison contient plusieurs épisodes. La durée est également en minutes.

-Acteurs
Attributs : id, name, birth_year
Les acteurs peuvent apparaître dans plusieurs oeuvres, ce qui crée des relations N‑N.

-Réalisateurs
Attributs : id, name
Un film peut avoir plusieurs réalisateurs, d’où une table dédiée pour la relation N‑N.

-Genres
Attributs : id, name
Les genres sont des catégories simples et réutilisables

-Castings
Attributs : id, actor_id, movie_id, episode_id, role
Cette table permet de représenter la distribution.

-Réalisateurs de films
Attributs : movie_id, director_id
C’est la table de relation N‑N entre films et réalisateurs

-Utilisateurs
Attributs : id, username
Les utilisateurs servent uniquement à noter les films

-Notes
Attributs : id, movie_id, user_id, rating




### Relationships

In this section you should include your entity relationship diagram and describe the relationships between the entities in your database.

**************************************************
- Un film peut avoir plusieurs réalisateurs, et un réalisateur peut travailler sur plusieurs films (relation N‑N via movie_directors)
- Un film peut appartenir à plusieurs genres, et un genre peut être associé à plusieurs films (relation N‑N via movie_genres)
- Un acteur peut jouer dans plusieurs film ou épisode, et chaque film/épisode peut avoir plusieurs acteurs (relation N‑N via casting)
- Une série possède plusieurs saisons, mais chaque saison appartient à une seule série (relation 1‑N)
- Une saison contient plusieurs épisodes, mais chaque épisode appartient à une seule saison (relation 1‑N)
- Un utilisateur peut attribuer plusieurs notes, mais chaque note appartient à un seul utilisateur (relation 1‑N)
- Un film peut recevoir plusieurs notes, mais chaque note concerne un seul film (relation 1‑N)




                 +------------------+
                 |      USERS       |
                 +------------------+
                 | id (PK)          |
                 | username         |
                 +------------------+
                          |
                          | 1
                          | 
                          | N
                 +------------------+
                 |     RATINGS      |
                 +------------------+
                 | id (PK)          |
                 | movie_id (FK)    |
                 | user_id (FK)     |
                 | rating           |
                 +------------------+
                          ^
                          | N
                          | 
                          | 1
+------------------+      |
|      MOVIES      |------+
+------------------+
| id (PK)          |
| title            |
| release_year     |
| duration         |
| description      |
+------------------+
      ^       ^
      |       |
      |       | (N)
      |       |
      | (N)   +------------------+
      |       |   MOVIE_GENRES   |
      |       +------------------+
      |       | movie_id (FK)    |
      |       | genre_id (FK)    |
      |       +------------------+
      |                 ^
      |                 | (N)
      |                 |
      |        +------------------+
      |        |     GENRES       |
      |        +------------------+
      |        | id (PK)          |
      |        | name             |
      |        +------------------+
      |
      | (N)
      |
+------------------+
| MOVIE_DIRECTORS  |
+------------------+
| movie_id (FK)    |
| director_id (FK) |
+------------------+
          ^
          | (N)
          |
+------------------+
|    DIRECTORS     |
+------------------+
| id (PK)          |
| name             |
+------------------+


+------------------+        +------------------+
|      SERIES      | 1    N |     SEASONS      |
+------------------+--------+------------------+
| id (PK)          |        | id (PK)          |
| title            |        | series_id (FK)   |
| start_year       |        | season_number    |
| end_year         |        +------------------+
+------------------+                |
                                    | 1
                                    | 
                           +------------------+
                           |    EPISODES      |
                           +------------------+
                           | id (PK)          |
                           | season_id (FK)   |
                           | episode_number   |
                           | title            |
                           | duration         |
                           +------------------+
                                    ^
                                    | (N)
                                    |
+------------------+                |
|     CASTINGS     |----------------+
+------------------+
| id (PK)          |
| actor_id (FK)    |
| movie_id (FK)    |
| episode_id (FK)  |
| role             |
+------------------+
           ^
           | (N)
           |
+------------------+
|     ACTORS       |
+------------------+
| id (PK)          |
| name             |
| birth_year       |
+------------------+




## Optimizations

In this section you should answer the following questions:

* Which optimizations (e.g., indexes, views) did you create? Why?

******************************************
Pour les index :
sur movie_id dans ratings pour accélérer le calcul des moyennes,
sur actor_id dans castings pour les filmographies,
sur series_id dans seasons,
sur season_id dans episodes.
Pour les vues :
les films les mieux notés,
la distribution complète d’un film,
la liste des épisodes d’une série.


## Limitations

In this section you should answer the following questions:

* What are the limitations of your design?
* What might your database not be able to represent very well?

Ma base ne gère pas :
les récompenses,
les données financières,
les critiques textuelles,
les plateformes de streaming,
les genres pour les séries,
les durées au format HH:MM.

