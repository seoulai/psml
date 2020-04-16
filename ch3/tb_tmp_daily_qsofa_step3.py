from base_etl import BaseETL

class TbTmpDailyqSOFAStep3(BaseETL):

    def run(
        self,
    ):
        """ 혈압(BP) 데이터 추출
        """

        sql = """
            SELECT date_id
                   , subject_id
                   , MIN(bp) AS bp
              FROM (
                    SELECT CAST(charttime AS DATE) AS date_id
                           , subject_id
                           , CAST(valuenum AS INT) AS bp
                      FROM chartevents
                    WHERE itemid IN ( '51', '442', '455', '6701', '220179', '220050')
                   ) tmp
            WHERE bp BETWEEN 0 AND 400
            GROUP BY subject_id
                     , date_id
        """

        df = self.df_from_sql(db_name="mimic", sql=sql)
        self.insert(df, db_name="mimic_tmp", tb_name="tb_tmp_daily_qsofa_step3")


if __name__ == "__main__":
    obj = TbTmpDailyqSOFAStep3()
    obj.run()

