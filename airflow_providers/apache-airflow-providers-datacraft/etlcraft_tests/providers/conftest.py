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
    except:  # noqa: E722
        # Запуск контейнера PostgreSQL с маппингом на порт 5438
        # Если в системе нет контейнера с базой для тестов то создаем
        # и немного ждем для инициализации
        client.containers.run(
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
        "from_datacraft": {"datasources": "Data from Datacraft"},
        "metadata_json": {
            "object_one": "value_one",
            "object_two": "value_two",
        },

        "format_for_etlcraft_datasources": "json",
        "format_for_yaml": "yaml",

        "source_for_etlcraft_templated_file": "templated_file",
        "source_for_etlcraft_other_variable": "other_variable",
        "source_for_etlcraft_datasources": "datacraft_variable",
        "source_for_etlcraft_file": "file",

        "path_for_etlcraft_datasources": "",
        "path_for_etlcraft_templated_file": "some_path/",

        "source_for_etlcraft_metaconfigs": "templated_file",
        "format_for_etlcraft_metaconfigs": "json",
        "path_for_etlcraft_metaconfigs": "../apache-airflow-providers-datacraft-defaults/airflow/providers/datacraft/defaults/metaconfigs.json",

        "source_for_etlcraft_base": "templated_file",
        "format_for_etlcraft_base": "json",
        "path_for_etlcraft_base": "../apache-airflow-providers-datacraft-defaults/airflow/providers/datacraft/defaults/base_example_for_tests.json",

        "source_for_etlcraft_base_datasources": "other_variable",
        "format_for_etlcraft_base_datasources": "json",
        "path_for_etlcraft_base_datasources": "base_datasources",
        "base_datasources": {"datasources": "Data from Datacraft 2"},

        "source_for_etlcraft_presets": "templated_file",
        "format_for_etlcraft_presets": "json",
        "path_for_etlcraft_presets": "../apache-airflow-providers-datacraft-defaults/airflow/providers/datacraft/defaults/presets.json",

        "source_for_etlcraft_metadata": "templated_file",
        "format_for_etlcraft_metadata": "yaml",
        "path_for_etlcraft_metadata": "../apache-airflow-providers-datacraft-defaults/airflow/providers/datacraft/defaults/metadata.yaml",
    }
    return variables
