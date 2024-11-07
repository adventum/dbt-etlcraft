import time

import docker
import pytest
from airflow import settings
from airflow.utils import db


@pytest.fixture(scope='session', autouse=True)
def setup_db():
    # Создаем контейнер с базой
    client = docker.from_env()

    try:
        # Проверяем, существует ли контейнер с именем "providers_postgres_tests"
        # и если да, но выключен - запускаем
        existing_container = client.containers.get("providers_postgres_tests")
        if existing_container.status == "exited":
            existing_container.start()
    except:
        # Запуск контейнера PostgreSQL с маппингом на порт 5438
        # Если в системе нет контейнера с базой для тестов то создаем
        # и немного ждем для инициализации
        postgres_container = client.containers.run(
            "postgres:13",
            name="providers_postgres_tests",
            environment={
                "POSTGRES_USER": "airflow",
                "POSTGRES_PASSWORD": "airflow",
                "POSTGRES_DB": "airflow_test"
            },
            ports={'5432/tcp': 5438},
            detach=True
        )
        time.sleep(5)

    settings.SQL_ALCHEMY_CONN = "postgresql+psycopg2://airflow:airflow@localhost:5438/airflow_test"
    db.initdb()

    yield

    # Очищаем бд после тестов
    db.resetdb()


# @pytest.fixture(scope='session', autouse=True)
# def setup_db():
#     # Создание временной БД в памяти
#     settings.SQL_ALCHEMY_CONN = "sqlite:////:memory:"
#     db.initdb()
#
#     yield
#     db.resetdb()


@pytest.fixture
def get_airflow_variables(request):
    variables: dict = {
        "from_datacraft": "Data from Datacraft",
        "metadata_json": {
            "object_one": "value_one",
            "object_two": "value_two",
        },
        "format_for_config_json": "json",
        "format_for_config_yaml": "yaml",
        "source_for_config_templated_file": "templated_file",
        "source_for_config_other_variable": "other_variable",
        "source_for_config_datacraft_variable": "datacraft_variable",
        "source_for_config_file": "file",
        "path_for_config": "some_path/"
    }
    return variables
