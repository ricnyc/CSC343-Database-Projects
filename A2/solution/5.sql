SET search_path TO imdb;

--the smallest title
create view table1 as
select *
from (roles NATURAL JOIN movies NATURAL JOIN  people) m1
where title = (
	select min(title)
	from (roles NATURAL JOIN movies) m2
	where m1.person_id = m2.person_id and m1.year = m2.year
);

---person in the three consecutive years movies
create view table2 as
select distinct T1.person_id, T1.name, T1.year as year1, T1.title as movie1, T2.year as year2, T2.title as movie2, T3.year as year3, T3.title as movie3
from table1 T1, table1 T2, table1 T3
where T1.person_id = T2.person_id and  T2.person_id = T3.person_id and T1.person_id = T3.person_id and T1.year+1 = T2.year and T2.year+1 = T3.year and T1.year+2 = T3.year;

select *
from table2 t2
where year1 = (
	select max(year1)
	from table2
	where table2.person_id = t2.person_id 
)
order by t2.person_id;

drop view table1 cascade;

