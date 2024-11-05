import pytest

from airflow import settings
from airflow.utils import db


@pytest.fixture(scope='session', autouse=True)
def setup_db():
    # Создание временной БД в памяти
    settings.SQL_ALCHEMY_CONN = "sqlite:////:memory:"
    db.initdb()

    yield
    db.resetdb()
