---
api_version: Официальное API
---
## Описание
Активирует синхронизацию для [[Airbyte Connection]].
## Аргументы
- `airbyte_conn_id` (см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
- `connection_id` или `connection_name`— ID или название Airbyte Connection, синхронизации которого нужно активировать. Если передан аргумент `name`, то  становится обязательным аргумент `connections_list`. В этот аргумент нужно передать результат вызова оператора [[AirbyteListConnectionsOperator]].
## Возвращаемое значение
Словарь с параметрами синхронизации, в т. ч. `jobId`.