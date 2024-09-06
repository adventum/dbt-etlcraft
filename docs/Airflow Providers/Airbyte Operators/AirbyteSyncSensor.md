---
api_version: Официальное API
---
## Описание
Ждет окончания синхронизации для [[Airbyte Connection]].
## Аргументы
- `airbyte_conn_id` (см. [[Airbyte Operators#Общие аргументы всех операторов|Общие аргументы]])
- `job_id`, `connection_id` или `connection_name` — ID задачи на синхронизацию, ID или название Airbyte Connection, синхронизации которого нужно дождаться. Если передан аргумент `connection_id`, то  становится обязательным аргумент `jobs_list`. В этот аргумент нужно передать результат вызова оператора [[AirbyteListJobsOperator]]]. Если передан `connection_name` — то кроме `jobs_list` обязательным становится еще один аргумент — `connections_list`. В него нужно передать результаты вызова [[AirbyteListConnectionsOperator]].