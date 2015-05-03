SET search_path TO imdb;

create view table1 as
select distinct AVG(rating) as avgrating, count(keyword_id) as keywords, movie_id
from movies NATURAL JOIN movie_keywords
group by movie_id;

create view table2 as(
select distinct keywords, AVG(avgrating) as avgrating
from table1
group by keywords
UNION 
select 0 as keywords, AVG(rating) as avgrating
from movies
where not exists(
	select *
	from table1
	where table1.movie_id = movies.movie_id
));

create view table3 as
select distinct keywords, avgrating
from table2
order by keywords;

select t1.keywords, t1.avgrating
from table3 t1, table3 t2
where t1.avgrating = t2.avgrating and t1.keywords = t2.keywords;

drop view table1 cascade;

