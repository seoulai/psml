-- SQL 2.2
-- 최초 입원 시간, 마지막 입원 시간을 구하는 SQL
SELECT subject_id
       , MIN( admittime) AS first_admittime
       , MAX( admittime) AS last_admittime
 FROM admissions
GROUP BY subject_id
