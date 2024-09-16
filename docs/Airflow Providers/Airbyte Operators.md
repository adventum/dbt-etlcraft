# Операторы для работы с Airbyte
## Общие аргументы всех операторов
- Все операторы принимают аргумент `airbyte_conn_id`, который должен быть равен идентификатору валидного [Airflow Connection](https://airflow.apache.org/docs/apache-airflow/stable/howto/connection.html#creating-a-connection-with-the-ui). Оно должно иметь тип `Airbyte`, параметр `schema` — `http` или `https`, `Host` (домен, на котором размещен Airbyte), `Port` (80 для http, 443 для https) и если применимо — `Login` и `Password`. Если `airbyte_conn_id` не задан как аргумент оператора, то используется `airbyte_default`.
- Многие операторы принимают `workspace_id` и `workspace_name` — ID и название [[Airbyte Workspace]], в котором нужно выполнить действие. Если передан аргумент `workspace_name`, то становится обязательным аргумент `workspaces_list`. В этот аргумент нужно передать результат вызова оператора `AirbyteListWorkspaces`.
```dataview
TABLE api_version AS "Версия API" FROM "Airflow Providers/Airbyte Operators"
WHERE file.name != "README"
```
