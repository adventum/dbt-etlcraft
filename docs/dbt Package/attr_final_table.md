---
category: sub_main
step: 6_attribution
sub_step: 9_final_table
in_main_macro: attr
doc_status: ready
---
# macro `attr_final_table`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "attr_final_table")
SORT doc_status
```
## Описание

Это девятый шаг макроса `attr`. Этот макрос формирует окончательную таблицу с атрибуционными данными. Он включает в себя данные из предыдущих этапов и устанавливает порядок сортировки по времени.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
  params = none,
  funnel_name=none,
  limit0=none
```
## Функциональность

Сначала в макросе происходит настройка материализации данных: устанавливается порядок  сортировки по времени (`__datetime`).

Выборка данных для окончательной таблицы происходит через присоединение результатов двух предыдущих макросов: `attr_join_to_attr_prepare_with_qid` и `attr_model`.

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.
## Пример

Файл в формате sql в папке models. Название файла `attr_myfirstfunnel_final_table`

Содержимое файла:
```sql
-- depends_on: {{ ref('attr_myfirstfunnel_model') }}

-- depends_on: {{ ref('attr_myfirstfunnel_join_to_attr_prepare_with_qid') }}

{{ etlcraft.attr() }}
```
