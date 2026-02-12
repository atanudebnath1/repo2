
/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles.
- Concentrates on remote positions with specified salaries.
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), offering strategic insights for career development in data analysis.
*/


SELECT
    skills, count(jpf.job_id) as demand
FROM
    job_postings_fact as jpf
    INNER JOIN skills_job_dim as sjd on jpf.job_id = sjd.job_id
    INNER JOIN skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY skills
ORDER BY demand DESC
LIMIT 5
-- more in demand


SELECT
    skills, round(avg(salary_year_avg),0) as money
FROM
    job_postings_fact as jpf
    INNER JOIN skills_job_dim as sjd on jpf.job_id = sjd.job_id
    INNER JOIN skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY money DESC
LIMIT 25
-- more in payment value

------------

WITH skills_demand AS
(  
    SELECT
        skills, count(jpf.job_id) as demand,sd.skill_id
    FROM
        job_postings_fact as jpf
        INNER JOIN skills_job_dim as sjd on jpf.job_id = sjd.job_id
        INNER JOIN skills_dim as sd on sjd.skill_id = sd.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY sd.skill_id
    ORDER BY demand DESC
    
    -- more in demand
), 
    skill_avg_salary as
    (
        SELECT
        skills, 
        round(avg(salary_year_avg),0) as money, 
        sd.skill_id
    FROM
        job_postings_fact as jpf
        INNER JOIN skills_job_dim as sjd on jpf.job_id = sjd.job_id
        INNER JOIN skills_dim as sd on sjd.skill_id = sd.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
         AND job_work_from_home = TRUE
    GROUP BY sd.skill_id
    ORDER BY money DESC
    
    -- more in payment value
    )
SELECT 
    sd.skills, money, demand
FROM
    skills_demand as sd 
    INNER JOIN skill_avg_salary as sas 
    ON sd.skill_id = sas.skill_id
ORDER BY demand desc, money desc
limit 25

---- below is without using CTEs

SELECT 
    sd.skills, 
    round(avg(salary_year_avg),0) as money,
    count(jpf.job_id) as demand
FROM
       job_postings_fact as jpf
        INNER JOIN skills_job_dim as sjd on jpf.job_id = sjd.job_id
        INNER JOIN skills_dim as sd on sjd.skill_id = sd.skill_id
WHERE 
     job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
         AND job_work_from_home = TRUE
GROUP BY sd.skills
ORDER BY demand desc, money desc
LIMIT 25
;