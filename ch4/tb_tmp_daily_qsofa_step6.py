from base_etl import BaseETL
from sqlalchemy import types

class TbTmpDailyqSOFAStep6(BaseETL):

    def run(
        self,
    ):

        sql = """
            SELECT *
                   , rr_score + bp_score + gcs_score AS qsofa_score
              FROM (
                    SELECT date_id
                           , subject_id
                           , rr
                           , bp
                           , gcs
                           , CASE WHEN rr >= 22 THEN 1 ELSE 0 END AS rr_score
                           , CASE WHEN bp <= 100 THEN 1 ELSE 0 END AS bp_score
                           , CASE WHEN gcs < 15 THEN 1 ELSE 0 END AS gcs_score
                      FROM tb_tmp_daily_qsofa_step5
                   ) tmp
        """

        df = self.df_from_sql(db_name="mimic_tmp", sql=sql)

        dtype = {
            'date_id': types.DATE,
            'subject_id': types.INTEGER,
            'rr': types.INTEGER,
            'bp': types.INTEGER,
            'gcs': types.INTEGER,
            'rr_score': types.INTEGER,
            'bp_score': types.INTEGER,
            'gcs_score': types.INTEGER,
            'qsofa_score': types.INTEGER,
        }
        df.set_index(["date_id", "subject_id"])
        self.insert(df, db_name="mimic", tb_name="daily_qsofa", dtype=dtype)


if __name__ == "__main__":
    obj = TbTmpDailyqSOFAStep6()
    obj.run()

