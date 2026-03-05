SELECT 
    sd.skills,
    COUNT(jof.job_id) AS count_job, ROUND((COUNT(jof.job_id)::FLOAT * 100/ sum(COUNT(jof.job_id)) OVER ())::NUMERIC, 2) AS percantage
FROM job_postings_fact jof
JOIN skills_job_dim sjd ON sjd.job_id = jof.job_id
JOIN skills_dim sd ON sd.skill_id = sjd.skill_id
WHERE jof.job_location ILIKE '%poland%'
GROUP BY sd.skills
ORDER BY count_job DESC;
