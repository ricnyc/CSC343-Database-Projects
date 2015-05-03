
SET search_path TO imdb;

	
create view person as(
Select name, movie_id
From people NATURAL JOIN writers p1
Where exists(
	Select *
	From (people NATURAL JOIN roles) p2
	Where p2.name = 'Pitt, Brad' and p2.movie_id = p1.movie_id
)
UNION
Select name, movie_id
From people NATURAL JOIN composers p1
Where exists(
	Select *
	From (people NATURAL JOIN roles) p2
	Where p2.name = 'Pitt, Brad' and p2.movie_id = p1.movie_id
));

Select distinct name, COUNT(movie_id) as bradtimes
From person
Group by name
Order by name;


drop view person cascade;

