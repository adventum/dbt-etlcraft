---
category: auxiliary
step: 2_staging
sub_step: 1_join
in_sub_main_macro: join_mt_datestat, join_yd_datestat, join_yd_datestat_smart, join_ym_events
doc_status: ready
---

# macro `get_min_max_date`

## Описание

Этот макрос находит минимальную и максимальную даты в указанной таблице.

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
    stage,
    sourcetype_name,
    pipeline_name,
    override_target_model_name=none,
    search_table_list=none,
    min_max_date_query=none
```
## Функциональность

Если аргументы `search_table_list` и `override_target_model_name` не заданы, макрос обратится к `system.columns`.

Или, если есть, к `override_target_model_name` + значениям обязательных аргументов.

Так макрос найдёт искомую таблицу и колонку с датой (`__date`).

Далее макрос запросит минимальное и максимальное значение из такой колонки и вернёт их списком при помощи вспомогательного макроса `dbt_utils.get_query_results_as_dict`.
