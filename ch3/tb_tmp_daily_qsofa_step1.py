from base_etl import BaseETL

class TbTmpDailyqSOFAStep1(BaseETL):

    def run(
        self,
    ):
        """ chartevents 테이블에 저장된 일자(date) 데이터 추출
        """

        sql = """
            SELECT CAST(charttime AS DATE) AS date_id
                   , subject_id
              FROM chartevents
            GROUP BY subject_id
                     , CAST(charttime AS DATE)
        """
        df = self.df_from_sql(db_name="mimic", sql=sql)
        self.insert(df, db_name="mimic_tmp", tb_name="tb_tmp_daily_qsofa_step1")


if __name__ == "__main__":
    obj = TbTmpDailyqSOFAStep1()
    obj.run()

