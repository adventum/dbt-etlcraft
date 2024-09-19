---
api_version: Устаревшее API
description: 
type: operator
doc_status: ready
status: не готово
---
## Описание
Создает новый [[Terms/DAG|коннектор]].
## Аргументы
- `airbyte_conn_id` (см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
- `workspace_id` или `workspace_name` + `workspaces_list` (см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
- `name`— название коннектора, который нужно создать.
- `dockerImageTag` — ссылка на образ коннектора в репозитории Docker
- `documentationUrl` — ссылка на документацию
## Возвращаемое значение
Словарь с параметрами созданного коннектора, в т. ч. `destinationDefinitionId`.