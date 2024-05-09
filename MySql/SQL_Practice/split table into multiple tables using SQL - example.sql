I have this table Cars: 

MODEL nvarchar(20) 
STYLE nvarchar(20) 
ENGINE nvarchar(5) 
CAPACITY smallint 
MAX_SPEED smallint 
PRICE smallmoney 
MARKET nvarchar(20) 
COMPETITOR nvarchar(20) 
 

And I would like to split it into 3 tables via SQL query: 

Cars: 

MODEL nvarchar(20) 
STYLE nvarchar(20) 
MAX_SPEED smallint 
PRICE smallmoney 
 

Engine: 

ENGINE nvarchar(5) 
CAPACITY smallint 
 

Market: 

MARKET nvarchar(20) 
COMPETITOR nvarchar(20) 

 

 

 

 

 

 

 

Easiest way. Select... Into will create new tables: 

SELECT DISTINCT 
    ENGINE, 
    CAPACITY 	
INTO Engine 
FROM CARS 
 
 
SELECT DISTINCT 
    MARKET, 
    COMPETITOR 
INTO Market 
FROM CARS 
 

Then just drop the defunct/no longer existing or functioning columns from the original table.

Ex: 

ALTER TABLE Cars DROP COLUMN ENGINE
ALTER TABLE Cars DROP COLUMN CAPACITY 
ALTER TABLE Cars DROP COLUMN MARKET
ALTER TABLE Cars DROP COLUMN COMPETITOR 
 

This will do specifically what you are asking. However, I'm not sure that is what you want - there is then no reference from the car to the engine or market details - so information is lost. 

If "ENGINE" and "MARKET" define the keys of the new table, I'd suggest leaving those columns on the car table as foreign keys. Eg only DROP Capacity and Competitor. 

You may wish to create the primary key on the new tables too. Eg: ALTER TABLE ENGINE ADD CONSTRAINT [PK_Engine] PRIMARY KEY CLUSTERED ENGINE ASC 
not
 

 

 

 

 

 

 

 

 

Other way:(doing it all at once) 

 

create table Engine 
( 
    EngineId int identity(1,1) not null primary key, 
    Engine nvarchar(5) not null, 
    Capacity smallint not null 
) 
go 
 
insert into Engine 
(Engine, Capacity) 
(select distinct Engine,Capacity from Cars) 
go 
 
alter table Cars 
add EngineId int null 
go 
 
update Cars 
set Cars.EngineId = e.EngineId 
from Engine e where  e.Engine = Cars.Engine 
go 
 
 
create table Market 
( 
    Id int identity(1,1) not null primary key, 
    Market nvarchar(20) not null, 
    Competitor nvarchar(20) not null 
) 
go 
 
insert into Market 
(Market, Competitor) 
(select distinct Market,Competitor from Cars) 
go 
 
alter table Cars 
add MarketId int null 
go 
 
update Cars 
set Cars.MarketId = m.MarketId 
from Market m where  m.Market = Cars.Market 
go 
 
 
alter table Cars 
drop column Market; 
 
 
alter table Cars 
drop column Competitor; 
 
 
alter table Cars 
drop column Engine; 
 
 
alter table Cars 
drop column Capacity; 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

 

Practice Example: 

-- create a table 

CREATE TABLE students ( 

  id INTEGER PRIMARY KEY, 

  name TEXT NOT NULL, 

  gender TEXT NOT NULL 

); 

-- insert some values 

INSERT INTO students VALUES (1, 'Ryan', 'M'); 

INSERT INTO students VALUES (2, 'Joanna', 'F'); 

-- fetch some values 

SELECT * FROM students;--  WHERE gender = 'F'; 

  

-- Create a table for distinct genders 

CREATE TABLE Gender AS 

SELECT DISTINCT gender 

FROM students; 

  

select * from Gender; 

  

  

CREATE TABLE Details AS 

SELECT DISTINCT id,name 

FROM students; 

  

select * from Details group by id; 

  

  

(/*create table Gender(gender TEXT NOT NULL); 

  

select distinct  

gender 

into Gender 

from students;*/ )-- this way is not working 