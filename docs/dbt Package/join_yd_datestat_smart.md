---
category: sub_main
step: 2_staging
sub_step: 1_join
in_main_macro: join
doc_status: ready
---
# macro `join_yd_datestat_smart`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "join_yd_datestat_smart")
SORT doc_status
```
## Описание

Этот подвид макроса `join` предназначен для работы с данными источника `yd` (они относятся к пайплайну `datestat`) - отдельная версия именно для данных, где есть smart.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
    sourcetype_name,
    pipeline_name,
    relations_dict,
    date_from,
    date_to,
    params,
    limit0=none
```
## Функциональность

Макрос обрабатывает данные источника `yd`, для которого есть стримы и `custom_report`, и`custom_report_smart`. Эти данные относятся к пайплайну `datestat`.

Для этих данных макрос ищет `relations` при помощи вспомогательного макроса [[get_relations_by_re]], затем создаёт таблицу-источник при помощи вспомогательного макроса `dbt_utils.union_relations`. (Этот макрос из пакета dbt_utils, он не относится к etlcraft).

При помощи дополнительного макроса [[get_min_max_date]] в макросе задаются переменные 
`date_from` и `date_to`, которые участвуют в отборе данных.

Далее полученные данные макрос обрабатывает (происходит переименование полей, для некоторых столбцов вводится LowCardinality).

Для этой таблицы задаётся её линк (это будет использоваться на будущих шагах):
- `toLowCardinality('AdCostStat') AS __link`

#task по факту линк не задан. Спросить У Валерии, почему так - может, он мешался или ошибки были? по идее надо линк добавить, как у обычной версии - то есть в макросе join_yd_datestat

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.

## Пример

Файл в формате sql в папке models. Название файла `[NAME]`

Содержимое файла:
```sql
SOMETHING INSIDE
```
#task  спросить у Валерии, как именно это используется (как называется файл, какие данные в depends_on и как макрос join понимает, куда распределить - в проекте два макроса - join_yd_datestat и join_yd_datestat_smart - или один?) . В тестовых данных примера нет.