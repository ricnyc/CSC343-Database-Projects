SET search_path TO imdb;

--the smallest title
create view table1 as
select max(movie_id) as max
from movies;


create view table2 as
select rating, movie_id, title
from movies
where movies.year &lt; 1990;

insert into movies
select (movie_id + (select max(max) from table1)) as movie_id, table2.title || ': The Sequel' as title,  2020 as year, table2.rating as rating
from table2;


drop view table1 cascade;
drop view table2 cascade;

