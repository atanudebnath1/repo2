
SELECT job_title_short, salary_year_avg, job_location
from jan23jobs
union
SELECT job_title_short, salary_year_avg, job_location
from feb23jobs
union
SELECT job_title_short, salary_year_avg, job_location
from mar23jobs


/*
Find job postings from the first quarter that have a salary greater than $70K
- Combine job posting tables from the first quarter of 2023 (Jan–Mar)
- Gets job postings with an average yearly salary > $70,000
*/

with temp_result_set as (
SELECT *
from jan23jobs
union all
SELECT *
from feb23jobs
union all
SELECT *
from mar23jobs
)
select job_id, salary_year_avg 
from temp_result_set
where salary_year_avg > 70000 ORDER by salary_year_avg 
;