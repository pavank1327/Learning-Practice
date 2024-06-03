-- SELECT DATE_TRUNC('SECOND', CURRENT_TIMESTAMP) AS truncated_timestamp;

-- SELECT TRUNC('SECOND','CURRENT_TIMESTAMP') AS truncated_timestamp; -- not work 

-- SELECT DATE_TRUNC('second', 'current_date'::TIMESTAMP) AS truncated_timestamp; -- not work 

-- SELECT TRUNC('2022-05-15 14:30:45'::TIMESTAMP, 'SECOND') AS truncated_timestamp; -- not work 

-- SELECT TRUNC('2022-05-15 14:30:45', 'SECOND') AS truncated_timestamp; -- not work 

SELECT DATE_TRUNC('second', '2022-05-15 14:30:45'::TIMESTAMP) AS truncated_timestamp;

-- should use DATE_TRUNC() -- redshift