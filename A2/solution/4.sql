SET search_path TO imdb;

create view table1 as
select cast((m2.year - (m2.year%10)) as char(4))||'s' as decade, movie_id,title,rating
from movies m2
where rating = (
	select max(rating)
	from movies
	where movies.year &lt;= (m2.year - (m2.year%10)+9) and movies.year &gt;= (m2.year - (m2.year%10)) 
);


Create View all_Writer as 
select Distinct person_id
from writers;

--non_super movies
create view table2 as(
Select  movie_id from movies 
Except 
Select  movie_id from table1
); 

Create View none_superWrite as
select person_id 
from  table2 Natural join writers;
      
--super writers
create view table3 as(
Select person_id from all_Writer
Except 
Select person_id from none_superWrite
); 
   
Select name as writer,title as supermovie,rating,decade
From table3 natural join people natural join writers natural join table1 
Order by name,decade,title;



drop view table1 cascade;
drop view table2 cascade;
drop view table3 cascade;

