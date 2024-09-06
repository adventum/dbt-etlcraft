---
api_version: Официальное API
---
## Описание
Возвращает информацию по имеющимся задачам на синхронизацию.
## Аргументы
- `airbyte_conn_id` (см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
- `connection_id` или `connections_name`— ID или название Airbyte Connection, который нужно обновить. Если передан аргумент `connection_name`, то  становится обязательным аргумент `connections_list`. В этот аргумент нужно передать результат вызова оператора [[AirbyteListConnectionsOperator]].
- statuses — список статусов задач, которые нужно оставить. Допустимые значения: `pending`, `running`, `incomplete`, `failed`, `succeeded`, `cancelled`. Значение по умолчанию: `[pending, running]`.
## Возвращаемое значение
Список словарей с полями:
- `jobId`,
- `status`
- `jobType`
- `connectionId`