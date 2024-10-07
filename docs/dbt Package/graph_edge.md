---
category: sub_main
step: 4_graph
sub_step: 4_edge
in_main_macro: graph
doc_status: ready
---
# macro `graph_edge`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "graph_edge")
SORT doc_status
```
## Описание

Это четвёртый шаг макроса `graph`. Данный макрос обрабатывает данные из `graph_unique`, создавая таблицу с гранями графа, содержащую информацию о связях между узлами и группами.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
  params=none,
  stage_name=none,
  limit0=none
```
## Функциональность

Сначала происходит настройка материализации данных. В `config` используется `post_hook` - он указывает на необходимость выполнения действия после завершения загрузки данных.

Технически `post_hook` используется для вставки данных из `graph_edge` в целевую таблицу с заменой.

Далее в макросе происходит создание временной таблицы `join_left` для хранения соединения между уникальными ключами и узлами. Внутри неё происходит соединение таблицы `graph_tuples` с таблицей `graph_unique` по ключам.

И в конце работы макроса создаётся выборка данных для графа, где каждому уникальному ключу соответствует один узел и одна группа.

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.
## Пример

Файл в формате sql в папке models. Название файла `graph_edge`

Содержимое файла:
```sql
-- depends_on: {{ ref('graph_unique') }}

-- depends_on: {{ ref('graph_tuples') }}

{{ datacraft.graph() }}
```
