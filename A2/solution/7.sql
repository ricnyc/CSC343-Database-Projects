SET search_path TO imdb;

--movies that M.night works on
create view table1 as
select movie_id, person_id
from people NATURAL JOIN (select movie_id, person_id from roles Union select* from cinematographers Union select* from directors Union select* from writers Union select* from composers) as m1
where name = 'Shyamalan, M. Night';

create view table2 as
select T1.person_id
from (select movie_id, person_id from roles Union select* from cinematographers Union select* from directors Union select* from writers Union select* from composers) as T1
where T1.movie_id in (
	select T2.movie_id
	from (select movie_id, person_id from roles Union select* from cinematographers Union select* from directors Union select* from writers Union select* from composers) as T2
	where T1.movie_id = T2.movie_id);

--clean cinematographers 
delete from cinematographers where exists (
select*
from table2
where cinematographers.person_id = table2.person_id);

delete from cinematographers where exists (
select*
from table1
where cinematographers.movie_id = table1.movie_id);

--clean composers
delete from composers where exists (
select*
from table2
where composers.person_id = table2.person_id);

delete from composers where exists (
select*
from table1
where composers.movie_id = table1.movie_id);

--clean directors 
delete from directors where exists (
select*
from table2
where directors.person_id = table2.person_id);

delete from directors where exists (
select*
from table1
where directors.movie_id = table1.movie_id);

--clean writers
delete from writers where exists (
select*
from table2
where writers.person_id = table2.person_id);

delete from writers where exists (
select*
from table1
where writers.movie_id = table1.movie_id);

--clean roles
delete from roles where exists (
select*
from table2
where roles.person_id = table2.person_id);

delete from roles where exists (
select*
from table1
where roles.movie_id = table1.movie_id);

--clean people
delete from people where exists (
select*
from table2
where people.person_id = table2.person_id);

--clean movie_genres
delete from movie_genres where exists(
select*
from table1 
where table1.movie_id = movie_genres.movie_id);

--clean movie_keywords
delete from movie_keywords where exists(
select*
from table1 
where table1.movie_id= movie_keywords.movie_id);

--clean movies
delete from movies where exists(
select*
from table1 
where table1.movie_id = movies.movie_id);


drop view table1 cascade;
drop view table2 cascade;

