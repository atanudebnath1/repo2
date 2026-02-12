/*
What are the top skills based on salary?

- Look at the average salary associated with each skill for Data Analyst positions.
- Focuses on roles with specified salaries, regardless of location.
- Why? It reveals how different skills impact salary levels for Data Analysts and helps identify
  the most financially rewarding skills to acquire or improve.
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

