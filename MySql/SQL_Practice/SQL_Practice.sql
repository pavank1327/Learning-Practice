Update a single column on multiple rows with one SQL query: 

  

one way: one at once 

  

UPDATE [table] SET DATA="FOO" WHERE ID=23; 

UPDATE [table] SET DATA="ASD" WHERE ID=47; 

UPDATE [table] SET DATA="FGH" WHERE ID=83; 

UPDATE [table] SET DATA="JKL" WHERE ID=88; 

UPDATE [table] SET DATA="QWE" WHERE ID=92; 

UPDATE [table] SET DATA="BAR" WHERE ID=97; 

  

Another way : all at once (check if this work or not) 

  

UPDATE [table] 

  SET DATA=("FOO", "ASD", "FGH", "JKL", "QWE", "BAR")  

  WHERE ID=(23, 47, 83, 88, 92, 9); 			--> not working  

  

  

  

 

 

 

 

 

 

 

 

 

 

 

Another Way: All at once using CASE: 

  

/*SELECT first_name, age 

FROM Customers; 

select * from Customers;*/ 

-- alter table Customers add Cont_No; 

/*UPDATE Customers 

SET Cont_No=("123", "456", "789", "101112", "131415")  

WHERE customer_id = (1,3,5,4,2);*/ 

  

  

update  Customers 

set Cont_No= 

case  

when customer_id = 1 then  "123" 

when customer_id = 2 then  "456" 

when customer_id = 4 then "789" 

when customer_id = 5 then "101112"  

when customer_id = 3 then  "131415" 

end; 

  

-- working  multiple rows of same column in a table are updated  

  

  

 

 

 

 

 

 

Creating Procedure: 

  

DELIMITER // 

CREATE PROCEDURE add_to_Cust_table() 

BEGIN 

    UPDATE Customers 

    SET Cont_No = 

        CASE  

            WHEN customer_id = 1 THEN '000' 

            WHEN customer_id = 2 THEN '456' 

            WHEN customer_id = 4 THEN '0000' 

            WHEN customer_id = 5 THEN '101112' 

            WHEN customer_id = 3 THEN '131415' 

        END; 

END // 

DELIMITER ; 

  

  

--> updating contact no - with user given values 

  

DELIMITER // 

CREATE PROCEDURE update_Cont_No(IN p_customer_id INT, IN p_new_cont_no VARCHAR(255)) 

BEGIN 

    UPDATE Customers 

    SET Cont_No = p_new_cont_no 

    WHERE customer_id = p_customer_id; 

END // 

DELIMITER ; 

  

  

--> call this procedure by providing values for the parameters: 

  

CALL update_Cont_No(1, '000'); 

CALL update_Cont_No(2, '456'); 

CALL update_Cont_No(4, '0000'); 

CALL update_Cont_No(5, '101112'); 

CALL update_Cont_No(3, '131415'); 

  

  

  

  

practice functions: 

  

SELECT DATABASE(); 

  

SELECT CURRENT_USER(); 

  

  

  

 

 

 

 

 

 

 

 

 

 

 

--> creation and updating multiple values in multiple tables: 

  

/* create temp table a_new as  

select 'a' x, 'b' y, 'c' z, 100 value 

union all 

select 'a1', 'b1', 'c1', 200 value; 

  

create temp table a_old as  

select 'a' x, 'b' y, 'c' z, 300 value 

union all 

select 'a1', 'b1', 'c1', 500 value; */ 

  

/* update a_new as a 

set value = b.value 

from a_old b 

where (b.x,b.y,b.z) = (a.x,a.y,a.z);*/ 

  

-- select * from a_new; 

/*update a_new n, a_old o 

set n.y = 0,o.x=1 

where n.z= 'c1' and o.y = 'b1'; 

  

*/ 

  

  

select * from a_old o 

inner join a_new n on n.x = o.x; 

  

  

select * from a_old o 

inner join a_new n;--  on n.x = o.x;--> this also works displaying all the data in two tables at once 

  

  

/*UPDATE a_new 

SET y = 0 

WHERE z = 'c1';*/ 

  

/* UPDATE a_old AS o 

SET o.x = 1 

WHERE o.y = 'b1';*/ 

  

-- delete from a_old  where value in (0); 

/* select * from a_old o  

inner join a_new n on  n.value in (300,500)  

where o.value in (300,500); 

  

  

  

--> updating old and new data tables at the same time(need to learn): 

  

conditions : 

  

1) data in both the tables need to be updates anddiplayed in same time. 

  

2) need to execute task with only one query. 

  

  

  

   

  

  

  

  

  

  

  

 

 