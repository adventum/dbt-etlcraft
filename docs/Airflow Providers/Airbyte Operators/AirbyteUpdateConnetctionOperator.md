---
api_version: Официальное API
---
## Описание
Обновляет [[Airbyte Connection]].
## Аргументы
- `airbyte_conn_id` (см. [[Airflow Providers/Airbyte Operators/README#Общие аргументы всех операторов|Общие аргументы]])
- `id` или `name`— ID или название Airbyte Connection, который нужно обновить. Если передан аргумент `name`, то  становится обязательным аргумент `connections_list`. В этот аргумент нужно передать результат вызова оператора [[AirbyteListConnectionsOperator]].
- словарь `params`, который содержит следующие параметры:
    - `configurations` — параметры стримов
    - `schedule` — параметры расписания запуска
    - `namespaceDefinition` — правила нейминга таблиц с данными: `destination` (по умолчанию), `source` или `custom_format`. Если задан `custom_format`, то можно также задать `namespaceFormat`
    - `prefix` — префикс, который будет прибавляться к названиям таблиц
    - `nonBreakingSchemaUpdatesBehavior` (по умолчанию `ignore`)
    - `status` — `active`, `inactive` или `deprecated`
## Возвращаемое значение
Словарь с параметрами обновленного Airbyte Connection, в т. ч. `connectionId`.