from base_etl import BaseETL

class TbTmpDailyqSOFAStep5(BaseETL):

    def run(
        self,
    ):

        sql = """
            SELECT st0.date_id
                   , st0.subject_id
                   , st1.rr
                   , st2.bp
                   , st3.gcs
              FROM tb_tmp_daily_qsofa_step1 st0
            LEFT OUTER JOIN tb_tmp_daily_qsofa_step2 st1
                         ON ( st0.date_id = st1.date_id
                              AND st0.subject_id = st1.subject_id
                            )
            LEFT OUTER JOIN tb_tmp_daily_qsofa_step3 st2
                         ON ( st0.date_id = st2.date_id
                              AND st0.subject_id = st2.subject_id
                            )
            LEFT OUTER JOIN tb_tmp_daily_qsofa_step4 st3
                         ON ( st0.date_id = st3.date_id
                              AND st0.subject_id = st3.subject_id
                            )
        """

        df = self.df_from_sql(db_name="mimic_tmp", sql=sql)
        self.insert(df, db_name="mimic_tmp", tb_name="tb_tmp_daily_qsofa_step5")


if __name__ == "__main__":
    obj = TbTmpDailyqSOFAStep5()
    obj.run()

