-- SQL 3.5
SELECT age_group
       , gender
       , COUNT(1) AS subject_cnt  -- 해석 1번
FROM detailed_patients
GROUP BY gender
         , age_group
ORDER BY age_group  -- 해석 2번
         , gender
;
