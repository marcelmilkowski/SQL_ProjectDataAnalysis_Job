SELECT 
    cd.name AS company_name,
    jof.job_title,
    jof.job_title_short,
    jof.job_location,
    CASE 
        WHEN jof.salary_rate = 'hour' THEN  round(jof.salary_hour_avg * 2080,0)
        ELSE round(jof.salary_year_avg,0)
    END AS salary_year
FROM job_postings_fact jof
JOIN company_dim cd on cd.company_id = jof.company_id
WHERE jof.salary_hour_avg IS NOT NULL 
     OR jof.salary_year_avg IS NOT NULL
     AND jof.job_title_short ILIKE '%data analyst%'
ORDER BY salary_rate DESC
LIMIT 10;