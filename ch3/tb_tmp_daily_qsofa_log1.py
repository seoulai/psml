from base_etl import BaseETL

class TbTmpDailyqSOFALog1(BaseETL):

    def run(
        self,
    ):
        """ 호흡률(RR) 데이터 추출
        """

        sql = """
            SELECT date_id
                  , subject_id
                  , MAX(rr) AS rr
              FROM (
                  SELECT CAST(charttime AS DATE) AS date_id
                         , subject_id
                         , CASE WHEN SUBSTRING(value, 1, 1) = '>' THEN CAST(SUBSTRING(value, 2, 2) AS INT)
                                ELSE CAST(valuenum AS INT)
                           END AS rr
                    FROM chartevents
                   WHERE itemid IN ('618', '615', '220210', '224690')
                   ) tmp
             WHERE rr BETWEEN 0 AND 300
             GROUP BY subject_id
                      , date_id
        """

        df = self.df_from_sql(db_name="mimic", sql=sql)
        self.insert(df, db_name="mimic_tmp", tb_name="tb_tmp_daily_qsofa_log1")


if __name__ == "__main__":
    obj = TbTmpDailyqSOFALog1()
    obj.run()

