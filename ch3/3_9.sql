-- SQL 3.9
WITH patients_is_sepsis AS                                                         
(   
    SELECT st0.subject_id                                                          
           , st1.icd9_codes                                                        
           , CASE WHEN st1.subject_id IS NOT NULL THEN 'true' ELSE 'false' END AS is_sepsis    
      FROM patients st0
    LEFT OUTER JOIN (
                     SELECT subject_id                                             
                            , ARRAY_AGG(icd9_code) AS icd9_codes
                       FROM diagnoses_icd                                          
                      WHERE icd9_code IN (SELECT icd9_code FROM d_icd_diagnoses WHERE short_title ILIKE '%sepsis%')
                      GROUP BY subject_id                                          
                    ) st1                                                          
                 ON (st0.subject_id = st1.subject_id)                              
)
, patients_septic_stat AS                  
(
    SELECT COUNT(1) AS subject_cnt                                            
           , SUM(CASE WHEN is_sepsis = 'true' THEN 1 ELSE 0 END) AS septic_subject_cnt
           , SUM(CASE WHEN is_sepsis = 'false' THEN 1 ELSE 0 END) AS non_septic_subject_cnt
      FROM patients_is_sepsis
)
SELECT subject_cnt
       , septic_subject_cnt
       , non_septic_subject_cnt
       , ROUND(septic_subject_cnt * 100.0 / subject_cnt, 2) AS septic_subject_per
  FROM patients_septic_stat
