-- SQL 3.3
SELECT st0.subject_id
       , st0.gender
       , st0.birth_date
       , st0.death_date
       , st0.is_dead
       , st1.first_admittime
       , st1.last_admittime
       , ROUND((CAST( st1.first_admittime AS date) - CAST(st0.birth_date AS date)) / 365.242, 2) AS first_admit_age
       , ROUND((CAST( st0.death_date AS date) - CAST(st0.birth_date AS date)) / 365.242, 2) AS life_span
  FROM (
        SELECT subject_id
               , gender
               , dob AS birth_date
               , dod AS death_date
               , CASE WHEN expire_flag = 0 THEN 'false'
                      ELSE 'true'
                  END
                 AS is_dead
          FROM patients
       ) st0
LEFT OUTER JOIN (
                 SELECT subject_id
                        , MIN( admittime) AS first_admittime
                        , MAX( admittime) AS last_admittime
                  FROM admissions
                 GROUP BY subject_id
                ) st1
             ON ( st0.subject_id = st1.subject_id)
