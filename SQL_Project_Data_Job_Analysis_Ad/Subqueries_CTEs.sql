select company_id, job_no_degree_mention
from job_postings_fact
where job_no_degree_mention = TRUE
limit 20;

SELECT name as company_name
from company_dim
where company_id in 
    (select company_id , job_no_degree_mention
from job_postings_fact
where job_no_degree_mention = TRUE
limit 20
-- this is wrong because for the sub-query,it must return only one column.
    );

    SELECT name as company_name, company_id
from company_dim
where company_id in 
    (select DISTINCT company_id 
from job_postings_fact
where job_no_degree_mention = TRUE
order by company_id
    );

WITH jan23jobs as
 (select * from job_postings_fact where EXTRACT(month from job_posted_date) =1
and 
EXTRACT(year from job_posted_date)=2023
 )
 select job_title_short, job_posted_date from jan23jobs limit 20;

 /*
find the companies that have the most job openings.
- get the total num of job postings per company id (job_postings_fact)
- return the total num of jobs with the company name (company_dim)
*/

select company_id, count(job_id) as job_count
from job_postings_fact
GROUP BY company_id
order by job_count desc
;

with jobs_per_co as 
( select company_id, count(job_id) as job_count from job_postings_fact 
GROUP BY company_id 
) 
select name as company_name, job_count from company_dim as c JOIN jobs_per_co as j 
on c.company_id = j.company_id 
ORDER BY job_count desc

;

WITH jobs_per_co AS (
    SELECT
        company_id,
        COUNT(job_id) AS job_count
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT
    c.name AS company_name,
    j.job_count
FROM company_dim AS c
INNER JOIN jobs_per_co AS j
    ON c.company_id = j.company_id
ORDER BY job_count DESC;

--doing the same thing without use of CTE
SELECT
    c.name AS company_name,
    COUNT(j.job_id) AS job_count
FROM company_dim c
JOIN job_postings_fact j
    ON c.company_id = j.company_id
GROUP BY c.name
ORDER BY job_count DESC;

-- suppose you want to keep even the companies which have NULL job postings. then you'll use LEFT JOIN, because it keeps all the rows on the left table
WITH jobs_per_co AS (
    SELECT
        company_id,
        COUNT(job_id) AS job_count
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT
    c.name AS company_name,
    j.job_count
FROM company_dim AS c
LEFT JOIN jobs_per_co AS j
    ON c.company_id = j.company_id
ORDER BY job_count ASC;
--where job_count = NULL

-- Try Challenge - Top 5 companies by job openings, but only for Data Analyst roles
 
select c.name as companies, count(j.job_id) as job_count
from 
company_dim as c inner join job_postings_fact as j 
on c.company_id = j.company_id
where 
job_title='%Data%' and job_title = '%Analyst%'
GROUP BY companies
order by job_count desc
limit 5
;

with skills_in_demand as (
select skill_id, count(job_id) as mention_freq from skills_job_dim
GROUP BY skill_id
)
select skills, mention_freq from
skills_in_demand as s join skills_dim as sjd 
on s.skill_id = sjd.skill_id
ORDER BY mention_freq desc
limit 5
;

with company_jobs as 
( select company_id, count(job_id) jobs_postings
    from job_postings_fact
    GROUP BY company_id
)
select company_id,
case 
	 when job_postings<10 then 'small'
	 when job_postings>=10 and jobs_postings<=50 then 'medium'
	 else 'large'
end as company_category
GROUP BY company_category

LIMIT 5
;

with company_jobs as 
( select company_id, count(job_id) as job_postings
from job_postings_fact
group by company_id
)
select name,
case 
	 when job_postings<10 then 'small'
	 when job_postings>=10 and job_postings<=50 then 'medium'
	 else 'large'
end as company_category

from company_jobs as cj Inner join company_dim as cd on cj.company_id = cd.company_id
order by company_category ASC

;

WITH remote_job_top_skills AS (
    SELECT
        sjd.skill_id,
        COUNT(jpf.job_id) AS job_postings
    FROM job_postings_fact jpf
    INNER JOIN skills_job_dim sjd
        ON jpf.job_id = sjd.job_id
    WHERE jpf.job_location = 'Anywhere'
    GROUP BY sjd.skill_id
)
SELECT
    rjts.skill_id,
    sd.skills AS skill_name,
    rjts.job_postings
FROM remote_job_top_skills rjts
INNER JOIN skills_dim sd
    ON rjts.skill_id = sd.skill_id
ORDER BY rjts.job_postings DESC
LIMIT 5;

WITH remote_job_top_skills AS (
    SELECT
        sjd.skill_id,
        COUNT(jpf.job_id) AS job_postings
    FROM job_postings_fact jpf
    INNER JOIN skills_job_dim sjd
        ON jpf.job_id = sjd.job_id
    WHERE jpf.job_work_from_home = TRUE
    GROUP BY sjd.skill_id
)
SELECT
    rjts.skill_id,
    sd.skills AS skill_name,
    rjts.job_postings
FROM remote_job_top_skills rjts
INNER JOIN skills_dim sd
    ON rjts.skill_id = sd.skill_id
ORDER BY rjts.job_postings DESC
LIMIT 5;
