---
api_version: Официальное API
---
## Описание
Возвращает информацию по имеющимся [[Airbyte Workspace]], позволяет осуществлять поиск по имени вместо ID.
## Аргументы
  - `airbyte_conn_id` (см. [[Airflow Providers/Airbyte Operators/README#Общие аргументы всех операторов|Общие аргументы]])
## Возвращаемое значение
Список словарей с полями `workspaceId` и `name`.