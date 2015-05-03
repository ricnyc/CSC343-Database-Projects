SET search_path TO imdb;

create view table1 as
select distinct movie_id, person_id
from roles;



create view table2 as(
select * from table1 
Union ALL
select * from cinematographers
Union ALL
select * from composers
Union ALL
select * from directors
Union ALL
select * from writers
);



create view table6 as
select  count(person_id) as positions, movie_id
from table2
group by movie_id;

create view table3 as(
select * from table1 
Union 
select * from cinematographers
Union 
select * from composers
Union
select * from directors
Union 
select * from writers
);


create view table5 as
select count(person_id) as people, movie_id
from table3
group by movie_id;

Create view haveanswer as
select distinct movie_id, positions, people
from table5 NATURAL JOIN table6
order by positions desc, people desc, movie_id;


--find the movie_id with no positions
Create view  rMovie as
select movie_id 
from (Select movie_id from movies) Mov Except (Select movie_id from table2);

Create view Mov_none as 
select movie_id,0 as positions, 0 as people 
from rMovie;

--combine all the movies
Create view final as 
select distinct movie_id, positions, people 
from (select * from Mov_none) Mov_result union (select * from haveanswer);

--final solution
select *
from final a1 natural join final
Order by positions DESC,people DESC,movie_id ASC;
	
drop view table1 cascade;

