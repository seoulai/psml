-- SQL 2.5
SELECT age_group
       , gender
       , COUNT(1) AS subject_cnt
FROM detailed_patients
GROUP BY gender
         , age_group
ORDER BY age_group
         , gender
