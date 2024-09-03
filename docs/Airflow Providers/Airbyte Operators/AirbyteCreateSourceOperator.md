---
api_version: Официальное API
---
## Описание
Создает новый [[Airbyte Source]].
## Аргументы
- `airbyte_conn_id` (см. [[Airflow Providers/Airbyte Operators/README#Общие аргументы всех операторов|Общие аргументы]])
- `workspace_id` или `workspace_name` + `workspaces_list`(см. [[Airflow Providers/Airbyte Operators/README#Общие аргументы всех операторов|Общие аргументы]])
- `definition_id` или `definition_name`— ID или название коннектора, который нужно использовать. Если передан аргумент `definition_name`, то  становится обязательным аргумент `source_definitions_list`. В этот аргумент нужно передать результат вызова оператора [[AirbyteListSourceDefinitionsOperator]].
- `configuration` — параметры (свои для каждого коннектора).
## Возвращаемое значение
Словарь с параметрами созданного коннектора, в т. ч. `sourceId`.