
/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2.
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
  providing insights into the most valuable skills for job seekers.
*/

-- these are the top demanded skills for remote jobs
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

WITH top_skills AS (
    SELECT
        sjd.skill_id,
        COUNT(jpf.job_id) AS job_postings
    FROM job_postings_fact jpf
    INNER JOIN skills_job_dim sjd
        ON jpf.job_id = sjd.job_id
    WHERE job_title_short = 'Data Analyst'
    GROUP BY sjd.skill_id
    ORDER BY job_postings desc
    limit 5
)
SELECT
    skills, job_postings as demand
FROM
    top_skills as ts INNER JOIN skills_dim as sd
    on ts.skill_id = sd.skill_id
ORDER BY demand desc


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
 