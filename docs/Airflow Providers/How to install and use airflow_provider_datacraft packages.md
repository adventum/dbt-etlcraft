### **Как установить и использовать пакеты airflow_provider_datacraft**

Кастомный провайдер airflow состоит из четырёх пакетов:
-  apache-airflow-providers-datacraft
-  apache-airflow-providers-datacraft-airbyte
-  apache-airflow-providers-datacraft-dags
-  apache-airflow-providers-datacraft-defaults

Все они находятся в папке `dbt-etlcraft/airflow_providers` Первый из них - главный

Предварительно рекомендуется установить пакетный менеджер - pip install hatch и обновить версию pip - `python -m pip install --upgrade pip`

**Способы установки:**
1. Быстрая установка, если не обязательно чтобы пакеты были в editable(development) режиме, то находясь в папке `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft` нужно выполнить команду `pip install .[with-datacraft-subpackages]` - это установит все 4 пакета

2. Установка каждого пакета в editable(development) режиме (позволяет менять код пакетов и видеть изменения сразу, не собирая и устанавливая их по-новой)
   Для этого нужно выполнить команду `pip install -e .` , находясь в каждой из директорий пакетов, приведенных ниже:
   `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft`
   `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft-airbyte`
   `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft-dags`
   `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft-defaults`

Если нужно собрать библиотеку(Например чтобы интегрировать пакеты с проектом airflow), нужно в каждой из папок выше запустить команду `hatch build` и в папке `dist` появится файл в формате `.whl`

Модули библиотеки, после установки, вызываются через from airflow.providers.datacraft.xxx

**Запуск тестов:**
Сами тесты находятся в директории `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft/etlcraft_tests/providers`

Для их запуска выполняется команда `hatch env run pytest etlcraft_tests` в директории `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft`

В `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft/etlcraft_tests/providers/unit_tests/fixtures/airflow_variables.py` есть функция, с помощью которой можно получить словарь с переменными airflow для тестирования

Также, для DAGs, Operators, требуется временная база данных, чтобы встроить в файл с тестом подключение к тестовой базе данных, нужно использовать функцию `setup_db` из  `dbt-etlcraft/airflow_providers/apache-airflow-providers-datacraft/etlcraft_tests/providers/unit_tests/utils/init_db.py`

Для удобства ее достаточно просто вызвать в файле с тестом и она будет работать во время выполнения всех тестов, например:
test_dags.py:
______________________________________________________________
`from airflow.decorators import dag`  
  
`from pendulum import datetime`  
`from airflow.operators.empty import EmptyOperator`  
==`from etlcraft_tests.providers.unit_tests.utils.init_db import setup_db`==  
  
==`init_airflow_test_db = setup_db`==  
  
  
`def test_run_dag():`  
    `@dag(`  
        `start_date=datetime(2024, 1, 1),`  
        `catchup=False,`  
    `)`  
    `def test_dag():`  
        `first_task = EmptyOperator(task_id="first_task")`  
  
    `dag_object = test_dag()`  
    `dag_object.test()`

________________________________________________________________________