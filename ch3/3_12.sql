-- SQL 3.12
SELECT drug
       , COUNT(1) AS vanco_cnt  -- 해석 1번
  FROM prescriptions
 WHERE subject_id = 4  -- 해석 2번
   AND drug ILIKE '%vancomycin%'  -- 해석 3번
   -- we exclude routes via the eye, ears, or topically
   AND route NOT IN ('OU','OS','OD','AU','AS','AD', 'TP')  -- 해석 4번
GROUP BY drug
;
