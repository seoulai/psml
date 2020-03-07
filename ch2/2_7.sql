-- SQL 2.7
SELECT *
  FROM diagnoses_icd
 WHERE icd9_code IN (SELECT icd9_code FROM d_icd_diagnoses WHERE short_title ILIKE '%sepsis%')
