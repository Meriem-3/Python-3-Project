-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it
--By Meriam Chebbi



-- Table Films

CREATE TABLE movies (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    release_year INTEGER,
    duration INTEGER,          -- durée en minutes
    description TEXT
);


-- Table Series 

CREATE TABLE series (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    start_year INTEGER,
    end_year INTEGER           -- NULL si la série est toujours en cours
);


-- Table Saisons

CREATE TABLE seasons (
    id INTEGER PRIMARY KEY,
    series_id INTEGER NOT NULL,
    season_number INTEGER NOT NULL,

    FOREIGN KEY (series_id) REFERENCES series(id)
);


-- Table Episodes

CREATE TABLE episodes (
    id INTEGER PRIMARY KEY,
    season_id INTEGER NOT NULL,
    episode_number INTEGER NOT NULL,
    title TEXT NOT NULL,
    duration INTEGER,

    FOREIGN KEY (season_id) REFERENCES seasons(id)
);


-- Table Acteurs

CREATE TABLE actors (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    birth_year INTEGER
);


-- Table Realisateurs

CREATE TABLE directors (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);


-- Table Genres

CREATE TABLE genres (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);



-- Table Castings (Distribution) 

CREATE TABLE castings (    /**Un acteur peut jouer dans un film OU un episode.**/
    id INTEGER PRIMARY KEY,
    actor_id INTEGER NOT NULL,
    movie_id INTEGER,          -- NULL si c’est un épisode / optionnel
    episode_id INTEGER,        -- NULL si c’est un film / optionnel
    role TEXT,

    FOREIGN KEY (actor_id) REFERENCES actors(id),
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (episode_id) REFERENCES episodes(id)
);



-- Table movie_directors 

CREATE TABLE movie_directors ( /**Relation N-N rntre films et réalisateurs**/
    movie_id INTEGER NOT NULL,
    director_id INTEGER NOT NULL,

    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (director_id) REFERENCES directors(id)
);


-- Table Utilisateurs

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    username TEXT NOT NULL UNIQUE
);


-- Table Ratings

CREATE TABLE ratings (
    id INTEGER PRIMARY KEY,
    movie_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    rating INTEGER NOT NULL CHECK (rating BETWEEN 1 AND 10),

    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table movies_genres

CREATE TABLE movie_genres (
    movie_id INTEGER,
    genre_id INTEGER,
    FOREIGN KEY (movie_id) REFERENCES movies(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);




-- Pour les Indexes

-- Accelère les recherches de notes par film
CREATE INDEX idx_ratings_movie ON ratings(movie_id);

-- Accelère les recherches de rôles par acteur
CREATE INDEX idx_castings_actor ON castings(actor_id);

-- Accelère la navigation dans les séries
CREATE INDEX idx_seasons_series ON seasons(series_id);

-- Accelère la navigation dans les épisodes
CREATE INDEX idx_episodes_season ON episodes(season_id);



-- Pour les vues

-- LEs films les mieux notés
CREATE VIEW top_rated_movies AS
SELECT
    movies.id,
    movies.title,
    AVG(ratings.rating) AS average_rating
FROM movies
JOIN ratings ON movies.id = ratings.movie_id
GROUP BY movies.id
ORDER BY average_rating DESC;

-- Liste des épisodes avec série + saison
CREATE VIEW episode_list AS
SELECT
    series.title AS series_title,
    seasons.season_number,
    episodes.episode_number,
    episodes.title AS episode_title,
    episodes.duration
FROM episodes
JOIN seasons ON episodes.season_id = seasons.id
JOIN series ON seasons.series_id = series.id
ORDER BY series.title, seasons.season_number, episodes.episode_number;

-- Vue movie_cast

CREATE VIEW movie_cast AS
SELECT 
    movies.title AS movie_title,
    actors.name AS actor_name,
    castings.role
FROM castings
JOIN movies ON movies.id = castings.movie_id
JOIN actors ON actors.id = castings.actor_id;