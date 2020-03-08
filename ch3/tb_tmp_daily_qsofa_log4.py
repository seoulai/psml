from base_etl import BaseETL

class TbTmpDailyqSOFALog4(BaseETL):

    def run(
        self,
    ):

        sql = """
            SELECT st0.date_id
                   , st0.subject_id
                   , st1.rr
                   , st2.bp
                   , st3.gcs
              FROM tb_tmp_daily_qsofa_log0 st0
            LEFT OUTER JOIN tb_tmp_daily_qsofa_log1 st1
                         ON ( st0.date_id = st1.date_id
                              AND st0.subject_id = st1.subject_id
                            )
            LEFT OUTER JOIN tb_tmp_daily_qsofa_log2 st2
                         ON ( st0.date_id = st2.date_id
                              AND st0.subject_id = st2.subject_id
                            )
            LEFT OUTER JOIN tb_tmp_daily_qsofa_log3 st3
                         ON ( st0.date_id = st3.date_id
                              AND st0.subject_id = st3.subject_id
                            )
        """

        df = self.df_from_sql(db_name="mimic_tmp", sql=sql)
        self.insert(df, db_name="mimic_tmp", tb_name="tb_tmp_daily_qsofa_log4")


if __name__ == "__main__":
    obj = TbTmpDailyqSOFALog4()
    obj.run()

