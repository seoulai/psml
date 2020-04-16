-- SQL 3.1
SELECT st0.subject_id
       , st0.gender
       , st0.dob AS birth_date
       , st0.dod AS death_date
       , CASE WHEN expire_flag = 0 THEN 'false'
              ELSE 'true'
          END
         AS is_dead
  FROM patients st0
