from tb_tmp_daily_qsofa_step1 import TbTmpDailyqSOFAStep1
from tb_tmp_daily_qsofa_step2 import TbTmpDailyqSOFAStep2
from tb_tmp_daily_qsofa_step3 import TbTmpDailyqSOFAStep3
from tb_tmp_daily_qsofa_step4 import TbTmpDailyqSOFAStep4
from tb_tmp_daily_qsofa_step5 import TbTmpDailyqSOFAStep5
from tb_tmp_daily_qsofa_step6 import TbTmpDailyqSOFAStep6


class ETLDailyqSOFA():
    """ Data Pipeline for creating daily qSOFA score
    """

    def run(
        self,
    ):
        TbTmpDailyqSOFAStep1().run()    # date
        TbTmpDailyqSOFAStep2().run()    # RR(respiratory rate)
        TbTmpDailyqSOFAStep3().run()    # BP(blood pressure)
        TbTmpDailyqSOFAStep4().run()    # GCS(Glasgow coma scale)
        TbTmpDailyqSOFAStep5().run()    # merge
        TbTmpDailyqSOFAStep6().run()    # final

if __name__ == "__main__":
    obj = ETLDailyqSOFA()
    obj.run()

