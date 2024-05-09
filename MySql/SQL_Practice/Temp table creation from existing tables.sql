select * into temp_enrol from enrollments; -- not working 

select * from temp_enrol;


select * into #temp_enrol from enrollments;



-- this is working

create table temp_table as 
SELECT *  FROM enrollments;

select * from temp_table;

