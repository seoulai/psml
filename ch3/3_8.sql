-- SQL 3.8
SELECT st0.subject_id
       , st1.icd9_codes
       , CASE WHEN st1.subject_id IS NOT NULL THEN true ELSE false END AS is_sepsis  -- 해석 3번
  FROM patients st0
LEFT OUTER JOIN (
                 SELECT subject_id
                        , ARRAY_AGG(icd9_code) AS icd9_codes  -- 해석 2번
                   FROM diagnoses_icd
                  WHERE icd9_code IN (SELECT icd9_code FROM d_icd_diagnoses WHERE short_title ILIKE '%sepsis%')
                  GROUP BY subject_id  -- 해석 1번
                ) st1
             ON (st0.subject_id = st1.subject_id)
