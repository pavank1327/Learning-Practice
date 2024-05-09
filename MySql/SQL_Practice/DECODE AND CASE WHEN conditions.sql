DECODE AND CASE WHEN:


Both DECODE and CASE WHEN are conditional expressions used in SQL to perform conditional logic. 
However, DECODE is specific to Oracle SQL, while CASE WHEN is more widely supported across different database systems.



DECODE (Oracle SQL):
Syntax: DECODE(expression, search1, result1, search2, result2, ..., default)
Example:

SELECT DECODE(grade, 'A', 'Excellent', 'B', 'Good', 'C', 'Fair', 'Poor') AS rating
FROM students;

-- --------------------------------------------------------------------------------------



CASE WHEN (Supported in many SQL dialects):
Syntax:

CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE default_result
END

-- ---------------------------------------------

SELECT 
    CASE 
        WHEN grade = 'A' THEN 'Excellent'
        WHEN grade = 'B' THEN 'Good'
        WHEN grade = 'C' THEN 'Fair'
        ELSE 'Poor'
    END AS rating
FROM students;




