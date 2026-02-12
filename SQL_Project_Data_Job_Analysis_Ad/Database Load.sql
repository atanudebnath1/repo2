select 
    job_id,
    job_title_short,
    job_posted_date at time zone 'UTC' at time zone 'JST' as date_of_posting ,
    salary_year_avg as salaryPerAnnum
from job_postings_fact
where salary_year_avg is not null
order by job_id
limit 100;

 at time zone 'IST'

select 
   *
from job_postings_fact
where salary_year_avg is not null
limit 100;

SELECT * from job_postings_fact limit 100;