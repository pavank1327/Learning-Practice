-- Create a Database Link:

CREATE DATABASE LINK db_link_name 
CONNECT TO remote_user IDENTIFIED BY password 
USING 'remote_tns';

-- Copy Data Using Insert-Select:

INSERT INTO local_table
SELECT * FROM remote_table@db_link_name;
	