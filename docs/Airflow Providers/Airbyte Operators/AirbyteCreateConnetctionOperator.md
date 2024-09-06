---
api_version: Официальное API
---
## Описание
Создает новый [[Airbyte Connection]].
## Аргументы
- `airbyte_conn_id` (см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
- `name` — название Airbyte Connection, которое нужно создать
- `source_id` или `source_name`— ID или название [[Airbyte Source]], который нужно использовать. Если передан аргумент `source_name`, то  становится обязательным аргумент `sources_list`. В этот аргумент нужно передать результат вызова оператора [[AirbyteListSourcesOperator]].
- `destination_id` или `destination_name`— ID или название [[Airbyte Destination]], который нужно использовать. Если передан аргумент `source_name`, то  становится обязательным аргумент `destinations_list`. В этот аргумент нужно передать результат вызова оператора [[AirbyteListDestinationsOperator]].
- словарь `params`, который содержит следующие параметры:
    - `configurations` — параметры стримов
    - `schedule` — параметры расписания запуска
    - `namespaceDefinition` — правила нейминга таблиц с данными: `destination` (по умолчанию), `source` или `custom_format`. Если задан `custom_format`, то можно также задать `namespaceFormat`
    - `prefix` — префикс, который будет прибавляться к названиям таблиц
    - `nonBreakingSchemaUpdatesBehavior` (по умолчанию `ignore`)
    - `status` — `active`, `inactive` или `deprecated`
## Возвращаемое значение
Словарь с параметрами созданного Airbyte Connection, в т. ч. `connectionId`.