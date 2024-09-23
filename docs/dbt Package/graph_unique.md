---
category: sub_main
step: 4_graph
sub_step: 3_unique
in_main_macro: graph
doc_status: ready
---
# macro `graph_unique`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "graph_unique")
SORT doc_status
```
## Описание

Это третий шаг макроса `graph`. Макрос `graph_unique` основывается на результатах `graph_lookup`, формируя таблицу, в которой каждому уникальному ключу соответствует только один узел.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
  params=none,
  stage_name=none,
  limit0=none
```
## Функциональность

Макрос настраивает материализацию данных: устанавливает порядок сортировки данных по ключевому хэшу.

Далее происходит выборка всех уникальных ключей из ранее созданной таблицы graph_lookup.

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.

## Пример

Файл в формате sql в папке models. Название файла `graph_unique`

Содержимое файла:
```sql
-- depends_on: {{ ref('graph_lookup') }}

{{ etlcraft.graph() }}
```
