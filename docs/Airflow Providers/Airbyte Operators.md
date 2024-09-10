# Операторы для работы с Airbyte
Пакет `airflow.providers.etlcraft.airbyte` позволяет вызывать различные методы API Airbyte как задачи в Airflow. Оператор `AirbyteGeneralOperator` дает возможность выполнить произвольный вызов API. Остальные операторы вызывают конкретные методы, но при этом в отличие от API дают возможность работать не с ID, а с именами объектов. Например, для создания [[Airbyte Source]] требуется указать ID [[Airbyte Workspace]]. В операторе вместо этого можно указать его имя. Чтобы преобразовать имя в ID, потребуется передать дополнительный аргумент, который получается с помощью другого оператора (в данном случае [[AirbyteListWorkspaceOperator]]. Если имя уникальное, оператор сам подставит в вызов API нужный ID, если нет — вернет ошибку.
## Версии API
На момент написания, есть две версии API Airbyte:
- [официальное API](https://reference.airbyte.com/reference/getting-started), в котором, однако часть функций отсутствует
- [устаревшее API](https://airbyte-public-api-docs.s3.us-east-2.amazonaws.com/rapidoc-api-docs.html), в котором есть все функции.

По операторах по возможности используется официальное API, те части, которые там еще не реализованы, сделаны с помощью устаревшего API.
## Общие аргументы всех операторов
- Все операторы принимают аргумент `airbyte_conn_id`, который должен быть равен идентификатору валидного [Airflow Connection](https://airflow.apache.org/docs/apache-airflow/stable/howto/connection.html#creating-a-connection-with-the-ui). Оно должно иметь тип `Airbyte`, параметр `schema` — `http` или `https`, `Host` (домен, на котором размещен Airbyte), `Port` (80 для http, 443 для https) и если применимо — `Login` и `Password`. Если `airbyte_conn_id` не задан как аргумент оператора, то используется `airbyte_default`.
- Многие операторы принимают `workspace_id` и `workspace_name` — ID и название [[Airbyte Workspace]], в котором нужно выполнить действие. Если передан аргумент `workspace_name`, то становится обязательным аргумент `workspaces_list`. В этот аргумент нужно передать результат вызова оператора `AirbyteListWorkspaces`.
```dataview
TABLE api_version AS "Версия API" FROM "Airflow Providers/Airbyte Operators"
WHERE file.name != "README"
```
