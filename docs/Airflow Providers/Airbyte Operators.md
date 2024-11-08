# Операторы для работы с Airbyte
## Общие аргументы всех операторов
- Все операторы принимают аргумент `airbyte_conn_id`, который должен быть равен идентификатору валидного [Airflow Connection](https://airflow.apache.org/docs/apache-airflow/stable/howto/connection.html#creating-a-connection-with-the-ui). Оно должно иметь тип `Airbyte`, параметр `schema` — `http` или `https`, `Host` (домен, на котором размещен Airbyte), `Port` (80 для http, 443 для https) и если применимо — `Login` и `Password`. Если `airbyte_conn_id` не задан как аргумент оператора, то используется `airbyte_default`.
- Многие операторы принимают `workspace_id` и `workspace_name` — ID и название [[Airbyte Workspace]], в котором нужно выполнить действие. Если передан аргумент `workspace_name`, то становится обязательным аргумент `workspaces_list`. В этот аргумент нужно передать результат вызова оператора `AirbyteListWorkspaces`.

| Название                                        | Версия API                                                             |
| ----------------------------------------------- | ---------------------------------------------------------------------- |
| [[AirbyteCreateConnetctionOperator]]            | Официальное API                                                        |
| [[AirbyteCreateDestinationDefinitionsOperator]] | Устаревшее API                                                         |
| [[AirbyteCreateDestinationOperator]]            | Официальное API                                                        |
| [[AirbyteCreateSourceDefinitionsOperator]]      | Устаревшее API                                                         |
| [[AirbyteCreateSourceOperator]]                 | Официальное API                                                        |
| [[AirbyteListConnectionsOperator]]              | Официальное API                                                        |
| [[AirbyteListDestinationDefinitionsOperator]]   | Устаревшее API                                                         |
| [[AirbyteListDestinationsOperator]]             | Официальное API                                                        |
| [[AirbyteListJobsOperator]]                     | Официальное API                                                        |
| [[AirbyteListSourceDefinitionsOperator]]        | Устаревшее API                                                         |
| [[AirbyteGeneralOperator]]                      | Официальное API или устаревшее API в зависимости от флага `use_legacy` |
| [[AirbyteListSourcesOperator]]                  | Официальное API                                                        |
| [[AirbyteListWorkspaceOperator]]                | Официальное API                                                        |
| [[AirbyteTriggerSyncOperator]]                  | Официальное API                                                        |
| [[AirbyteUpdateDestinationDefinitionsOperator]] | Устаревшее API                                                         |
| [[AirbyteUpdateSourceDefinitionsOperator]]      | Устаревшее API                                                         |
| [[AirbyteSyncSensor]]                           | Официальное API                                                        |
| [[AirbyteUpdateConnetctionOperator]]            | Официальное API                                                        |
| [[AirbyteUpdateDestinationOperator]]            | Официальное API                                                        |
| [[AirbyteUpdateSourceOperator]]                 | Официальное API                                                        |




