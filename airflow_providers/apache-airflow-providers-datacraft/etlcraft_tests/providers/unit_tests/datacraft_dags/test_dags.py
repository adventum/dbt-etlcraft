from airflow.decorators import dag

from pendulum import datetime
from airflow.operators.empty import EmptyOperator
from etlcraft_tests.providers.unit_tests.utils.init_db import setup_db

init_airflow_test_db = setup_db


def test_run_dag():
    @dag(
        start_date=datetime(2024, 1, 1),
        catchup=False,
    )
    def test_dag():
        first_task = EmptyOperator(task_id="first_task")

    dag_object = test_dag()
    dag_object.test()


def test_run_dag2():
    @dag(
        start_date=datetime(2024, 1, 1),
        catchup=False,
    )
    def test_dag():
        first_task2 = EmptyOperator(task_id="first_task2")

    dag_object = test_dag()
    dag_object.test()
