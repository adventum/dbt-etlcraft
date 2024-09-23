---
category: sub_main
step: 4_graph
sub_step: 6_qid
in_main_macro: graph
doc_status: ready
---
# macro `graph_qid`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "graph_qid")
SORT doc_status
```
## Описание

Это шестой шаг макроса `graph`. Это завершающий этап, в ходе которого `graph_qid` использует данные из предыдущих макросов для формирования итоговой таблицы, где каждому уникальному ключу соответствует идентификатор группы (`qid`).

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
  params=none,
  stage_name=none,
  limit0=none
```
## Функциональность

Сначала в макросе происходит настройка материализации данных: устанавливается порядок сортировки данных по дате, ссылке и идентификатору.

`pre_hook` указывает на необходимость выполнения предварительного хука при помощи вспомогательного макроса [[calc_graph]] перед выполнением запроса.

Далее происходит выборка данных для формирования итоговой таблицы: каждому уникальному ключу (`__link, __datetime, __id`) соответствует `qid` из ранее созданной таблицы `graph_glue`. Основой запроса является таблица `graph_glue`, которая соединена с таблицей `graph_lookup` по `key_number = node_id_left`

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.
## Пример

Файл в формате sql в папке models. Название файла `graph_qid`

Содержимое файла:
```sql
-- depends_on: {{ ref('graph_lookup') }}

-- depends_on: {{ ref('graph_glue') }}

{{ etlcraft.graph() }}
```
