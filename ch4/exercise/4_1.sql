-- SQL 4.1
-- daily_qsofa 테이블의 총 건수, qSOFA 건수(2점 이상), 정상 건수(2점 미만)를 구하고 총 건수 대비 qSOFA 건수, 정상 건수의 percentage를 구하자.
SELECT total_cnt
       , qsofa_cnt
       , ROUND(qsofa_cnt * 100.0 / total_cnt, 2) AS qsofa_per
       , normal_cnt
       , ROUND(normal_cnt * 100.0 / total_cnt, 2) AS normal_per
  FROM (
        SELECT COUNT(1) AS total_cnt
               , SUM(CASE WHEN qsofa_score >= 2 THEN 1 ELSE 0 END) AS qsofa_cnt
               , SUM(CASE WHEN qsofa_score < 2 THEN 1 ELSE 0 END) AS normal_cnt
          FROM daily_qsofa
        ) tmp
