WITH DuplicateRank AS (
    SELECT
        your_duplicate_column,
        ROW_NUMBER() OVER (PARTITION BY your_duplicate_column ORDER BY some_ordering_column) AS row_num
    FROM
        your_table
)
UPDATE your_table AS t
SET
    your_duplicate_column = NULL
FROM DuplicateRank dr
WHERE
    t.your_duplicate_column = dr.your_duplicate_column
    AND dr.row_num > 1; -- Keep only the first occurrence, assign NULL to others


------------------------------------------------------------------------------------------------------------------------------------------

-- example with table


-- Create the table
CREATE TABLE your_table (
    id INT PRIMARY KEY,
    your_duplicate_column VARCHAR(50),
    other_column INT
);

-- Insert data into the table
INSERT INTO your_table (id, your_duplicate_column, other_column)
VALUES
    (1, 'DuplicateValue', 100),
    (2, 'DuplicateValue', 200),
    (3, 'UniqueValue', 300),
    (4, 'AnotherDuplicate', 400),
    (5, 'AnotherDuplicate', 500);

-- View the data in the table before the update
SELECT * FROM your_table;

-- Update to assign NULL values to duplicate_column based on the condition
WITH DuplicateRank AS (
    SELECT
        your_duplicate_column,
        ROW_NUMBER() OVER (PARTITION BY your_duplicate_column ORDER BY id) AS row_num
    FROM
        your_table
)
UPDATE your_table AS t
SET
    your_duplicate_column = NULL
FROM DuplicateRank dr
WHERE
    t.your_duplicate_column = dr.your_duplicate_column
    AND dr.row_num > 1;

-- View the data in the table after the update
SELECT * FROM your_table;



--------------------------------------------------------------------------------------------------------------------------------------------

-- assigning null to only one duplicate column in a table


-- Create the table
CREATE TABLE your_table (
    id INT PRIMARY KEY,
    your_duplicate_column VARCHAR(50),
    other_column INT
);

-- Insert data into the table
INSERT INTO your_table (id, your_duplicate_column, other_column)
VALUES
    (1, 'DuplicateValue', 100),
    (2, 'DuplicateValue', 200),
    (3, 'UniqueValue', 300),	
    (4, 'AnotherDuplicate', 400),
    (5, 'AnotherDuplicate', 500);

-- View the data in the table before the update
SELECT * FROM your_table;

-- Update to assign NULL values to your_duplicate_column based on the condition
WITH DuplicateRank AS (
    SELECT
        id,
        your_duplicate_column,
        ROW_NUMBER() OVER (PARTITION BY your_duplicate_column ORDER BY id) AS row_num
    FROM
        your_table
)
UPDATE your_table AS t
SET		
    your_duplicate_column = CASE
                               WHEN dr.row_num > 1 THEN NULL
                               ELSE t.your_duplicate_column
                           END
FROM DuplicateRank dr
WHERE
    t.id = dr.id;

-- View the data in the table after the update
SELECT * FROM your_table  order by id;


-- Attending mandatary training sessions and support sessions and learning
