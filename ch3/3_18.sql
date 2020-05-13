-- SQL 3.18
WITH bilirubin_sofa AS
(
	SELECT charttime
         , subject_id
      	 , valuenum
		     , CASE WHEN valuenum < 1.2 THEN 0
                WHEN valuenum BETWEEN 1.2 AND 1.9 THEN 1
                WHEN valuenum BETWEEN 2.0 AND 5.9 THEN 2
                WHEN valuenum BETWEEN 6.0 AND 11.9 THEN 3
                WHEN valuenum > 12.0 THEN 4
            END AS sofa_score  -- 해석 1번
	  FROM labevents 
	 WHERE itemid = 50885  -- 해석 2번
) 
SELECT * 
  FROM bilirubin_sofa
 WHERE sofa_score > 1  -- 해석 3번
LIMIT 10;
