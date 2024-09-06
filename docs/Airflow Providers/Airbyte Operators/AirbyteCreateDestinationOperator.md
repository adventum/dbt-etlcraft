---
api_version: Официальное API
---
## Описание
Создает новый [[Airbyte Destination]].
## Аргументы
- `airbyte_conn_id` (см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
- `workspace_id` или `workspace_name` + `workspaces_list`(см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
- `definition_id` или `definition_name`— ID или название коннектора, который нужно использовать. Если передан аргумент `definition_name`, то  становится обязательным аргумент `destination_definitions_list`. В этот аргумент нужно передать результат вызова оператора [[AirbyteListDestinationDefinitionsOperator]].
- `configuration` — параметры (свои для каждого коннектора).
## Возвращаемое значение
Словарь с параметрами созданного коннектора, в т. ч. `destinationId`.