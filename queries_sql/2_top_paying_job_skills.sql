WITH top_payed_jobs AS (
    SELECT 
        cd.name AS company_name,
        jof.job_id,
        jof.job_title,
        CASE 
            WHEN jof.salary_rate = 'hour' THEN  round(jof.salary_hour_avg * 2080,0)
            ELSE round(jof.salary_year_avg,0)
        END AS salary_year
    FROM job_postings_fact jof
    JOIN company_dim cd ON cd.company_id = jof.company_id
    WHERE (jof.salary_hour_avg IS NOT NULL 
        OR jof.salary_year_avg IS NOT NULL)
        AND jof.job_title_short ILIKE '%data analyst%'
    ORDER BY salary_year DESC
    LIMIT 50
)
SELECT 
    sd.skills,
    sd.type,
    COUNT(*) AS job_count,
    string_agg(tpj.company_name, ', ') as companies
FROM skills_dim sd
JOIN skills_job_dim sjd ON sjd.skill_id = sd.skill_id
JOIN top_payed_jobs tpj ON tpj.job_id = sjd.job_id
GROUP BY sd.skills, sd.type
ORDER BY job_count DESC;