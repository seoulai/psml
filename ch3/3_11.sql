-- SQL 3.11
SELECT subject_id, drug, route -- 해석 1번
  FROM prescriptions
WHERE drug ILIKE '%vancomycin%'
   -- we exclude routes via the eye, ears, or topically
   AND route NOT IN ('OU','OS','OD','AU','AS','AD', 'TP')
LIMIT 5;
