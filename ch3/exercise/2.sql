-- 각 환자별 qSOFA 조건에 부합하는(2점 이상) 최초 시점은 언제일까?
-- 그리고 qSOFA 조건에 부합하는(2점 이상) 최초 시점은 환자의 차트 데이터가 기록된 전체 기간 대비 몇 % 에 도달한 시점일까? (daily_qsofa 테이블 기준)
SELECT * 
       , ROUND(
           CASE WHEN diff_date = 0 THEN 0
                ELSE diff_qsofa_date * 100.0 / diff_date
           END, 2)
       AS first_qsofa_date_per
  FROM (
        SELECT st0.subject_id AS subject_id
               , min_date_id
               , min_qsofa_date_id
               , max_date_id
               , (max_date_id - min_date_id) AS diff_date
               , (min_qsofa_date_id - min_date_id) AS diff_qsofa_date
          FROM (
                SELECT subject_id
                       , MIN(date_id) AS min_date_id
                       , MAX(date_id) AS max_date_id
                  FROM daily_qsofa
                GROUP BY subject_id
               ) st0
LEFT OUTER JOIN (
                 SELECT subject_id
                        , MIN(date_id) AS min_qsofa_date_id
                   FROM daily_qsofa
                  WHERE qsofa_score >= 2
                  GROUP BY subject_id
                ) st1
             ON (st0.subject_id = st1.subject_id)
       ) tmp
