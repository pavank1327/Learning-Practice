-- creating backup table


use Pavank

create table source_backup;

insert into source_backup
select *
from Source_Employee;

-- Create a backup (copy) of the existing table

use Pavank
SELECT *
INTO source_backup
FROM Source_Employee;

use Pavank
select * from source_backup;