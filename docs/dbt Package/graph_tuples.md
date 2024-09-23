---
category: sub_main
step: 4_graph
sub_step: 1_tuples
in_main_macro: graph
doc_status: ready
---
# macro `graph_tuples`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "graph_tuples")
SORT doc_status
```
## Описание

Это первый шаг макроса `graph`. Он предназначен для выполнения операций по склейке данных в графовую структуру. Он берет данные, преобразует их и готовит для дальнейшей обработки.
## Аргументы

Этот макрос принимает следующие аргументы:
```sql
  params=none,
  stage_name=none,
  limit0=none,
  metadata=project_metadata()
```
## Функциональность

Макрос обращается к `metadata`, берёт оттуда раздел `glue_models`. Проходит циклом по моделям склейки, забирая колонки и поле с датой,  объединяет эти данные. 

Затем проходит циклом по колонкам текущей модели склейки, создает временный SQL-запрос для текущей колонки.

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.

И в конце макрос создаёт таблицу с результатом запроса, где добавляет временные запросы в общий SQL-запрос.

## Пример

Файл в формате sql в папке models. Название файла `graph_tuples`

Содержимое файла:
```sql
-- depends_on: {{ ref('link_events') }}

{{ etlcraft.graph() }}
```
