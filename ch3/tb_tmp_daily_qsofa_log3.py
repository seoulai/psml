from base_etl import BaseETL

class TbTmpDailyqSOFALog3(BaseETL):

    def run(
        self,
    ):
        """ GCS 데이터 추출
        """

        sql = """
            SELECT date_id
                   , subject_id
                   , SUM(gcs) AS gcs
            FROM (
                  SELECT CAST(charttime AS DATE) AS date_id
                         , subject_id
                         , itemid
                         , MIN(valuenum) AS gcs
                    FROM chartevents
                   WHERE itemid IN ( '723', '223900', '454', '223901', '184', '220739')
                   GROUP BY itemid
                            , subject_id
                            , CAST(charttime AS DATE)
                 ) tmp
            GROUP BY subject_id
                     , date_id
        """

        df = self.df_from_sql(db_name="mimic", sql=sql)
        self.insert(df, db_name="mimic_tmp", tb_name="tb_tmp_daily_qsofa_log3")


if __name__ == "__main__":
    obj = TbTmpDailyqSOFALog3()
    obj.run()

