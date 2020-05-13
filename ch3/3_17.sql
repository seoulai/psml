-- SQL 3.17
WITH platelet_sofa AS
(
    SELECT charttime
           , subject_id
		       , valuenum
           , CASE WHEN valuenum >= 150 THEN 0
			            WHEN valuenum between 100 and 150 THEN 1
            			WHEN valuenum between 50 and 100 THEN 2
            			WHEN valuenum between 20 and 50 THEN 3
			            WHEN valuenum < 20 THEN 4
         		 END AS sofa_score  -- 해석 1번
      FROM labevents 
     WHERE itemid = 51265  -- 해석 2번
) 
SELECT *
  FROM platelet_sofa
 WHERE sofa_score > 1  -- 해석 3번
LIMIT 10;
