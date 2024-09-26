---
category: auxiliary
step: 1_silos
sub_step: 1_normalize
in_main_macro: normalize, combine
doc_status: ready
in_sub_main_macro: join_appmetrica_events, join_appmetrica_registry_appprofilematching, join_appsflyer_events, join_mt_datestat, join_sheets_periodstat, join_vkads_datestat, join_utmcraft_registry_utmhashregistry, join_yd_datestat, join_yd_datestat_smart, join_ym_events
---
# macro `get_relations_by_re`

## Описание

Этот макрос находит таблицы благодаря передаваемым аргументам (паттерны схемы базы данных и названия таблицы).

## Аргументы

Этот макрос принимает следующие аргументы:
```sql
schema_pattern, table_pattern, database=target.database
```
## Функциональность

Этот макрос находится внутри файла `clickhouse-adapters`. Для своей работы он обращается к вспомогательному макросу `get_tables_by_re_sql`, который также находится внутри файла `clickhouse-adapters`. 

Тот, в свою очередь, внутри себя обращается к макросу `get_table_types_sql` (который также находится внутри файла `clickhouse-adapters`). Для `Clickhouse`информация берётся из  `information_schema.tables`.

Итого это можно изобразить следующим образом:

Есть файл `clickhouse-adapters`. Внутри него макросы обращаются так:

`get_relations_by_re` 
↓
`get_tables_by_re_sql` : `from information_schema.tables` + `get_table_types_sql`