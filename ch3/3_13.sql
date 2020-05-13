-- SQL 3.13
WITH vanco_patients AS (
    SELECT COUNT(DISTINCT subject_id) AS vanco_subject_cnt -- 해석 1번
      FROM prescriptions
     WHERE drug ILIKE '%vancomycin%'
        -- we exclude routes via the eye, ears, or topically
       AND route NOT IN ('OU','OS','OD','AU','AS','AD', 'TP')
),
all_patients AS (
    SELECT COUNT(DISTINCT subject_id) AS subject_cnt  -- 해석 2번
    FROM prescriptions
)
SELECT vanco_patients.vanco_subject_cnt
       , all_patients.subject_cnt
       , ROUND( vanco_patients.vanco_subject_cnt * 100.0 / all_patients.subject_cnt, 2) AS vanco_per  -- 해석 3번
  FROM vanco_patients, all_patients  -- 해석 4번
;
