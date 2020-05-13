-- SQL 3.10
SELECT drug
  FROM prescriptions
 WHERE drug ILIKE '%vancomycin%'  -- 해석 1번
    -- we exclude routes via the eye, ears, or topically
   AND route NOT IN ('OU','OS','OD','AU','AS','AD', 'TP')  -- 해석 2번
GROUP BY drug
LIMIT 10;
