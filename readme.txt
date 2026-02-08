--By Meriam Chebbi


J'ai rajouter un fichier readme contenant les 
requetes qu'on pourra tester pour verifier le bon 
fonctionnement de la base.

si besoin "rm project.db"
ensuite sqlite3 project.db
        .read schema.sql
        .read queries.sql

1. Vérifier les films
SELECT * FROM movies;

2. Vérifier les acteurs
SELECT * FROM actors;

3. Vérifier les castings
SELECT * FROM castings;

4. Vérifier les réalisateurs
SELECT * FROM directors;

5. Vérifier les genres
SELECT * FROM genres;

6. Vérifier les relations film ↔ genre
SELECT movies.title, genres.name FROM movies JOIN movie_genres ON movies.id = movie_genres.movie_id JOIN genres ON genres.id = movie_genres.genre_id;

7. Vue : distribution d’un film (movie_cast)
SELECT * FROM movie_cast;

8. Films par genre (exemple : Romance)
SELECT movies.title FROM movies JOIN movie_genres ON movies.id = movie_genres.movie_id JOIN genres ON genres.id = movie_genres.genre_id WHERE genres.name = 'Romance';

9. Films de James Cameron
SELECT movies.title FROM movies JOIN movie_directors ON movies.id = movie_directors.movie_id JOIN directors ON directors.id = movie_directors.director_id WHERE directors.name = 'James Cameron';

10. Filmographie de Leonardo DiCaprio
SELECT movies.title FROM castings JOIN movies ON movies.id = castings.movie_id JOIN actors ON actors.id = castings.actor_id WHERE actors.name = 'Leonardo DiCaprio';

11. Liste des épisodes de Stranger Things (vue episode_list)
SELECT * FROM episode_list;

12. Films les mieux notés (vue top_rated_movies)
SELECT * FROM top_rated_movies;

13. Vérifier les saisons
SELECT * FROM seasons;

14. Vérifier les épisodes
SELECT * FROM episodes;

15. Vérifier les notes
SELECT * FROM ratings;


