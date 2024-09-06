---
api_version: Устаревшее API
---
## Описание
Возвращает информацию по имеющимся [[Коннектор|коннекторам]] для [[Airbyte Destination]].
## Аргументы
- `airbyte_conn_id` (см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
- `workspace_id` или `workspace_name` + `workspaces_list` (см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
## Возвращаемое значение
Список словарей с полями:
- `destinationDefinitionId`
- `name` 
- `dockerImageTag`
- `documentationUrl`