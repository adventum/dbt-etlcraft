---
api_version: Устаревшее API
---
## Описание
Возвращает информацию по имеющимся [[Коннектор|коннекторам]] для [[Airbyte Source]].
## Аргументы
- `airbyte_conn_id` (см. [[Airflow Providers/Airbyte Operators/README#Общие аргументы всех операторов|Общие аргументы]])
- `workspace_id` или `workspace_name` + `workspaces_list` (см. [[Airflow Providers/Airbyte Operators/README#Общие аргументы всех операторов|Общие аргументы]])
## Возвращаемое значение
Список словарей с полями:
- `sourceDefinitionId`
- `name` 
- `dockerImageTag`
- `documentationUrl`