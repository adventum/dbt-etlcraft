---
api_version: Официальное API
---
## Описание
Возвращает информацию по имеющимся [[Airbyte Source]].
## Аргументы
- `airbyte_conn_id` (см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
- `workspace_id` или `workspace_name` + `workspaces_list` (см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
## Возвращаемое значение
Список словарей с полями `sourceId`, `name` и `configuration`.