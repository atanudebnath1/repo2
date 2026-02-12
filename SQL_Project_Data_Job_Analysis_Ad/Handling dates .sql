/*
::DATE : converts date to a format by removing the time portion. 


*/

select * 
from job_postings_fact
limit 10;

select job_posted_date::date as dateOnly from job_postings_fact limit 10;

select '2023-09-18':: date,
    '3.14'::real,
    'true':: boolean,
    '123':: integer;

select job_posted_date at time zone 'utc' at time zone 'ist'
from job_postings_fact
limit 10;

select EXTRACT(month from job_posted_date) as month_only
from job_postings_fact
limit 10;

SELECT  job_schedule_type, 
    salary_year_avg, salary_hour_avg
from job_postings_fact
where job_posted_date > '2023-06-01'
GROUP BY job_schedule_type;

SELECT
    job_schedule_type,
    AVG(salary_year_avg) AS avg_salary_year,
    AVG(salary_hour_avg) AS avg_salary_hour
FROM job_postings_fact
WHERE job_posted_date > '2023-06-01'
GROUP BY job_schedule_type;

select count(job_title_short) as jobs, 
      EXTRACT (month from job_posted_date at time zone 'utc' at time zone 'est') as month
from job_postings_fact
where job_posted_date between '01-01-2023' and '31-12-2023'
group by month
order by month asc;

select job_title_short, job_schedule_type
from job_postings_fact
GROUP BY job_schedule_type;

SELECT
    DATE_TRUNC(
        'month',
        job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York'
    ) AS month,
    COUNT(*) AS job_count
FROM job_postings_fact
WHERE job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York'
      >= '2022-06-01'
  AND job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'America/New_York'
      < '2024-01-01'
GROUP BY month
ORDER BY month;

select c.name
from company_dim as c
left join job_postings_fact as j on c.company_id = j.company_id
where j.job_health_insurance = true
 and 
 (j.job_posted_date >= '2023-04-01' and 
    j.job_posted_date < '2023-07-01'
 )
 GROUP BY c.name
;

SELECT
    c.name
FROM company_dim c
JOIN job_postings_fact j
    ON c.company_id = j.company_id
WHERE j.job_health_insurance = true
  AND j.job_posted_date >= '2023-04-01'
  AND j.job_posted_date < '2023-07-01'
GROUP BY c.name;

create table jan23jobs as
(select * from job_postings_fact where EXTRACT(month from job_posted_date) =1
and 
EXTRACT(year from job_posted_date)=2023
)

select * from jan23jobs limit 20;
select * from feb23jobs limit 20;
select * from mar23jobs limit 20;

CREATE TABLE feb23jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 2
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;

  CREATE TABLE mar23jobs AS
SELECT *
FROM job_postings_fact
WHERE EXTRACT(MONTH FROM job_posted_date) = 3
  AND EXTRACT(YEAR FROM job_posted_date) = 2023;
