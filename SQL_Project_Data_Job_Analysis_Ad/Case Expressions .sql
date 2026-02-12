/*
label new columns as follows - 

'Anywhere' as 'Remote'
'New York' as 'Local'
otherwise label as 'Onsite'
*/

select job_title_short, job_location,
case
    when job_location = 'Anywhere' then 'remote'
    when job_location = 'New York' then 'local'
    else 'Onsite'
END 
    as 
    Location_Type
from job_postings_fact
limit 20;

select count(job_id) as job_count,
case
    when job_location = 'Anywhere' then 'remote'
    when job_location = 'New York' then 'local'
    else 'Onsite'
END 
    as 
    Location_Type
from job_postings_fact
group by Location_Type
limit 20;

SELECT count(job_id)
from job_postings_fact;
where job_location = NULL;