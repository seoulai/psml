import pandas as pd
from sqlalchemy import create_engine


class BaseETL():

    def conn(
        self,
        db_name,
    ):
        """ - db_name: 데이터베이스명
            db_name으로 입력된 데이터베이스에 대한 connection 정보를 리턴
        """
        engine = create_engine( "postgresql://postgres:mimic@127.0.0.1:5432/{}".format(db_name), encoding='utf-8')
        return engine

    def df_from_sql(
        self,
        db_name,
        sql,
    ):
        """ - db_name: 데이터베이스명
            - sql: SELECT SQL
            db_name에 입력된 데이터베이스에서 sql을 실행.
            pandas 라이브러리의 read_sql를 사용하여 DataFrame 리턴 
        """
        print("from {}".format(db_name))
        print(sql)
        engine = self.conn(db_name)
        return pd.read_sql(sql, engine)

    def insert(
        self,
        df,
        db_name,
        tb_name,
        if_exists="replace",
        dtype=None,
    ):
        """ - df: 데이터프레임
            - db_name: 데이터프레임
            - tb_name: 저장할 테이블명
            - dtype: 테이블에 대한 정의
            df에 저장된 데이터를 db_name.tb_name 에 insert
        """
            
        engine = self.conn(db_name)

        df.to_sql(
            con=engine,
            name=tb_name,
            if_exists=if_exists,
            dtype=dtype,
        )
        print("to {0}.{1}".format(db_name, tb_name))


if __name__ == "__main__":
    obj = BaseETL()
