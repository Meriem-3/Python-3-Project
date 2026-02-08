-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database
--By Meriam Chebbi


-- INSERT

-- Ajouter un film
INSERT INTO movies (title, release_year, duration, description)
VALUES ('Titanic', 1997, 195, 'Une romance tragique à bord du Titanic');

-- Ajouter un acteur
INSERT INTO actors (name, birth_year)
VALUES ('Leonardo DiCaprio', 1974);

INSERT INTO actors (name, birth_year)
VALUES ('Kate Winslet', 1975);

INSERT INTO actors (name, birth_year)
VALUES ('Millie Bobby Brown', 2004);

-- Ajouter un réalisateur
INSERT INTO directors (name)
VALUES ('James Cameron');

-- Associer un réalisateur à un film
INSERT INTO movie_directors (movie_id, director_id) VALUES (1, 1);

-- Ajouter un utilisateur
INSERT INTO users (username) VALUES ('alice');

-- Ajouter une note à un film
INSERT INTO ratings (movie_id, user_id, rating) VALUES (1, 1, 10);

--Ajouter un casting
INSERT INTO castings (actor_id, movie_id, role)
VALUES (1, 1, 'Jack Dawson');

INSERT INTO castings (actor_id, movie_id, role)
VALUES (2, 1, 'Rose DeWitt Bukater');

--AJouter casting pour ST
INSERT INTO castings (actor_id, episode_id, role)
VALUES (2, 1, 'Eleven');

--Ajouter une série
INSERT INTO series (title, start_year, end_year)
VALUES ('Stranger Things', 2016, NULL);

--Ajouter les saisons
INSERT INTO seasons (series_id, season_number)
VALUES 
(1, 1),
(1, 2);

--Ajouter les épisodes
--saisno 1
INSERT INTO episodes (season_id, episode_number, title, duration)
VALUES
(1, 1, 'Chapter One: The Vanishing of Will Byers', 47),
(1, 2, 'Chapter Two: The Weirdo on Maple Street', 55);

--saison 2
INSERT INTO episodes (season_id, episode_number, title, duration)
VALUES
(2, 1, 'MADMAX', 48),
(2, 2, 'Trick or Treat, Freak', 56);

--Ajouter Genres
INSERT INTO genres (name)
VALUES 
('Science Fiction'),
('Thriller'),
('Drama'),
('Horror'),
('Romance');

--Associer film au genre
--Inceprion
INSERT INTO movie_genres (movie_id, genre_id)
VALUES
(1, 3),  -- Drama
(1, 5);  -- Romance


--Shutter Island
INSERT INTO movie_genres (movie_id, genre_id)
VALUES
(2, 2),  -- Thriller
(2, 3);  -- Drama




-- SELECT


-- Obtenir tous les films
SELECT * FROM movies;

-- Obtenir les films sortis après 2015
SELECT title, release_year
FROM movies
WHERE release_year > 2015;

-- Obtenir les films d’un réalisateur donné
SELECT movies.title
FROM movies
JOIN movie_directors ON movies.id = movie_directors.movie_id
JOIN directors ON directors.id = movie_directors.director_id
WHERE directors.name = 'James Cameron';

-- Obtenir les films d’un genre donné
SELECT movies.title
FROM movies
JOIN movie_genres ON movies.id = movie_genres.movie_id
JOIN genres ON genres.id = movie_genres.genre_id
WHERE genres.name = 'Romance';

-- Obtenir la distribution d’un film
SELECT actors.name, castings.role
FROM castings
JOIN actors ON actors.id = castings.actor_id
WHERE castings.movie_id = 1;

-- Obtenir la filmographie d’un acteur
SELECT movies.title, movies.release_year
FROM castings
JOIN movies ON movies.id = castings.movie_id
JOIN actors ON actors.id = castings.actor_id
WHERE actors.name = 'Leonardo DiCaprio';

-- Obtenir les épisodes d’une série
SELECT series.title AS serie,
       seasons.season_number,
       episodes.episode_number,
       episodes.title
FROM episodes
JOIN seasons ON episodes.season_id = seasons.id
JOIN series ON seasons.series_id = series.id
WHERE series.title = 'Stranger Things'
ORDER BY seasons.season_number, episodes.episode_number;

-- Obtenir la moyenne des notes d’un film
SELECT movies.title, AVG(ratings.rating) AS moyenne
FROM movies
JOIN ratings ON movies.id = ratings.movie_id
WHERE movies.id = 1;



-- UPDATE

-- Modifier la durée d’un film
UPDATE movies
SET duration = 150
WHERE id = 1;

-- Modifier la note d’un utilisateur
UPDATE ratings
SET rating = 10
WHERE movie_id = 1 AND user_id = 1;


-- DELETE

--j'ai mis les fonctions DELETE en commentaire pour pouvoir tester
-- Supprimer une note

/** DELETE FROM ratings
WHERE id = 1; **/

-- Supprimer un film (et ses relations)

/** DELETE FROM movies
WHERE id = 1; **/


-- Les vues


-- Voir les films les mieux notés
SELECT * FROM top_rated_movies;

-- Voir la liste complète des épisodes
SELECT * FROM episode_list;