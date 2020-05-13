-- SQL 3.19
SELECT subject_id 
       , org_name
  FROM microbiologyevents 
 WHERE spec_type_desc = 'BLOOD CULTURE' -- 해석 1번
	 AND org_name != ''  -- 해석 2번
LIMIT 20;
