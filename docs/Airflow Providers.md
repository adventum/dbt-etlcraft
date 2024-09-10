
# Airflow-провайдеры
## Обзор
В **etlCraft** есть два провайдера для Apache Airflow:
- `apache_airflow_etlcraft_airbyte_provider`  — содержит операторы для вызова методов API Airbyte, может использоваться независимо от второго пакета
- `apache_airflow_etlcraft_dags_provider` — содержит заготовки для [[Terms/DAG|DAG]]’ов, которые могут подготовить все инструменты для сбора и обработки данных.
#task Проверить нейминг пакетов, убедиться, что в начале названия должно стоять apache
## `apache_airflow_etlcraft_airbyte_provider`
### Описание
Пакет `airflow_providers_etlcraft_airbyte` позволяет вызывать различные методы API Airbyte как задачи в Airflow. Оператор `AirbyteGeneralOperator` дает возможность выполнить произвольный вызов API. Остальные операторы вызывают конкретные методы, но при этом в отличие от API дают возможность работать не с ID, а с именами объектов. Например, для создания [[Airbyte Source]] требуется указать ID [[Airbyte Workspace]]. В операторе вместо этого можно указать его имя. Чтобы преобразовать имя в ID, потребуется передать дополнительный аргумент, который получается с помощью другого оператора (в данном случае [[AirbyteListWorkspaceOperator]]. Если имя уникальное, оператор сам подставит в вызов API нужный ID, если нет — вернет ошибку.
### Версии API
На момент написания, есть две версии API Airbyte:
- [официальное API](https://reference.airbyte.com/reference/getting-started), в котором, однако часть функций отсутствует
- [устаревшее API](https://airbyte-public-api-docs.s3.us-east-2.amazonaws.com/rapidoc-api-docs.html), в котором есть все функции.

По операторах по возможности используется официальное API, те части, которые там еще не реализованы, сделаны с помощью устаревшего API.
### Справочник
[[Airbyte Operators|Список операторов и документация к ним]]


Провайдер содержит:

[Airbyte Operators](Airbyte%20Operators.md)

- функции для сбора конфигурации
- конструктор DAG’ов, позволяющий решить следующие задачи:
    - установить в Airbyte необходимые коннекторы
    - настроить sources, destinations, и connections в Airbyte на основе конфигурации YAML
    - создание модели dbt по умолчанию
    - запускать обновление данных через Airbyte за нужные даты
    - запускать обработку через dbt

[Configs](Configs.md)

#task Заменить README на понятные описания в ссылке

[How DAGs work](How%20DAGs%20work.md)
```dataview
table status as "Status", assignee as "Assignee", due as "Due" from "etlCraft/etlCraft Documentation/Desctiption of DAGs"
```

Интеграция с dataCraft

## `apache_airflow_etlcraft_dags_provider`
### Описание
Все DAG’и проекта etlCraft имеют общую структуру для того, чтобы пользователю легче было построить собственную логику на основе имеющихся “строительных блоков”. 
### Параметры запуска
Во всех DAG’ах есть [параметр](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/params.html) `namespace`, который определяет:
- какие конфиги будут использованы (см. [[Configs]])
- где располагается папка с проектом dbt.
Папку проекта dbt можно поменять отдельно с помощью конфига [[base#dbt_dir]].
### Шаги работы
1. Во время парсинга DAG’а с помощью функции `get_configs(...)` определяются все конфиги, релевантные для него.

Все шаги далее представляют собой задачу или группу задач в Airflow.
2. Шаг `before`, на котором DAG выполняет подготовительную работу, например, создает необходимые папки (см. документацию по конкретному DAG’у).
3. Шаг `prepare`, на котором DAG определяет *список для итерации*. Он определяет содержимое всех задач на следующем этапе, например, соединения Airbyte, для которых нужно включить синхронизацию. Пользователь шага `prepare` и перед следующим шагом `iterate` может добавить задачу, которая будет модифицировать этот список.
4. Шаг `iterate`, на котором на каждый элемент списка для итерации создается [динамическая задача](https://airflow.apache.org/docs/apache-airflow/stable/authoring-and-scheduling/dynamic-task-mapping.html) или [динамическая группа задач](https://airflow.apache.org/docs/apache-airflow/stable/authoring-and-scheduling/dynamic-task-mapping.html).
5. Шаг `after`, на котором DAG очищает или освобождает выделенные ресурсы, например, удаляет созданные временные папки и файлы.
### Справочник
[[DAGs|Описание DAG’ов]]
## Установка

В среде с установленным Airflow выполнить:

```bash
pip install apache_airflow_etlcraft_dags_provider
```

Данная команда установит оба пакета. Если нужен только функционал, связанных с Airbyte, то нужно установить пакет `apache_airflow_etlcraft_dags_provider`
## Использование
В Airflow создать DAG со следующим содержимым:

```python
from apache_airflow_providers_etlcraft import DagBuilder
DagBuilder.create_dags() # Создаем все DAGи с параметрами по умолчанию
```

Пример с кастомизацией:
```python
from apache_airflow_providers_etlcraft import DagBuilder
dag = DagBuilder.prepare_dag("generate_models")
dag.schedule_interval = "@weekly" # Изменяем расписание запуска на 1 раз в неделю
def delete_normalize(prepared_tasks):
  del prepared_tasks['1_silos']['normalize']

dag.add_prepare_hook(delete_normalize) # Удаляем задачи, связанные со слоем normalize