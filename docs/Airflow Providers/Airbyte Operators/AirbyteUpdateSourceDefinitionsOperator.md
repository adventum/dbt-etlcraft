---
api_version: Устаревшее API
description: 
type: operator
doc_status: ready
status: не готово
---
## Описание
Обновляет имеющийся [[Terms/DAG|коннектор]].
## Аргументы
- `airbyte_conn_id` (см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
- `id` или `name`— ID или название коннектора, который нужно обновить. Если передан аргумент `name`, то  становится обязательным аргумент `source_definition_list`. В этот аргумент нужно передать результат вызова оператора [[AirbyteListSourceDefinitionsOperator]].
- `dockerImageTag` — ссылка на образ коннектора в репозитории Docker
- `documentationUrl` — ссылка на документацию
## Возвращаемое значение
Словарь с параметрами обновленного Airbyte Definition, в т. ч. `sourceDefinitionId`.