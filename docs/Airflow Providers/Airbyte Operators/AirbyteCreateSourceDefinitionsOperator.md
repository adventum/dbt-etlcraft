---
api_version: Устаревшее API
---
## Описание
Создает новый [[Коннектор|коннектор]].
## Аргументы
- `airbyte_conn_id` (см. [[Airflow Providers/Airbyte Operators/README#Общие аргументы всех операторов|Общие аргументы]])
- `workspace_id` или `workspace_name` + `workspaces_list` (см. [[Airflow Providers/Airbyte Operators/README#Общие аргументы всех операторов|Общие аргументы]])
- `name`— название коннектора, который нужно создать
- `dockerImageTag` — ссылка на образ коннектора в репозитории Docker
- `documentationUrl` — ссылка на документацию
## Возвращаемое значение
Словарь с параметрами созданного коннкетора, в т. ч. `sourceDefinitionId`.