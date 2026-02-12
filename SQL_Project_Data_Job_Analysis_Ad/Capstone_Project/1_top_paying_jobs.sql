

-- select job_id 
-- FROM job_postings_fact
-- where job_work_from_home = True

SELECT job_id, job_title,name as company_name, salary_year_avg, job_work_from_home
 
from job_postings_fact as jpf LEFT JOIN company_dim as c on jpf.company_id = c.company_id
where job_work_from_home = True 
    and salary_year_avg is not null
    and job_title_short = 'Data Analyst'
order by salary_year_avg desc
limit 10
;