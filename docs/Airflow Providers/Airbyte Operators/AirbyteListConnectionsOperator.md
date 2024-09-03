---
api_version: Официальное API
---
## Описание
Возвращает информацию по имеющимся [[Airbyte Source]].
## Аргументы
- `airbyte_conn_id` (см. [[Airflow Providers/Airbyte Operators/README#Общие аргументы всех операторов|Общие аргументы]])
- `workspace_id` или `workspace_name` + `workspaces_list` (см. [[Airflow Providers/Airbyte Operators/README#Общие аргументы всех операторов|Общие аргументы]])
## Возвращаемое значение
Список словарей с полями:
- `connectionsId`,
- `name`
- `sourceId`
- `destinationId`
- `status`
- `schedule`
- `nonBreakingSchemaUpdatesBehavior`
- `namespaceDefinition`
- `namespaceFormat`
- `prefix`
- `configurations`