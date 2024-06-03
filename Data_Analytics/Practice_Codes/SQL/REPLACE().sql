SELECT REPLACE('hello world', 'world', 'universe');

-- replaces string mentioned in a statement


SELECT REGEXP_REPLACE('hello world', 'o+', 'X'); 

-- replaces particular letter mentioned in a statement

-- need to replace o's in both the words in statement but only first word letter is replaced  

-- need to check



-- -----------------------------------------------------------

-- working on one column:

create table my_table (my_column varchar);

insert into my_table (my_column) values ('old_word');

select * from my_table;

UPDATE my_table
SET my_column = REPLACE(my_column, 'old_word', 'new_word')
WHERE my_column LIKE '%old_word%';

select * from my_table;

