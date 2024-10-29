---
api_version: Официальное API
description: 
type: operator
doc_status: ready
status: ready (нужен тест?)
---
## Описание
Возвращает информацию по имеющимся [[Airbyte Workspace]], позволяет осуществлять поиск по имени вместо ID.
## Аргументы
  - `airbyte_conn_id` (см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
## Возвращаемое значение
Список словарей с полями `workspaceId` и `name`.