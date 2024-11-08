---
category: sub_main
step: 2_staging
sub_step: 1_join
in_main_macro: join
doc_status: ready
---
# macro `join_ym_events`

## Список используемых вспомогательных макросов

| Name                    | Category  | In Sub-Main Macro                                                                                                                                                                                                                                           | Doc Status |
| ----------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- |
| [[get_adsourcedirty]]   | auxiliary | join_ym_events                                                                                                                                                                                                                                              | ready      |
| [[get_min_max_date]]    | auxiliary | join_mt_datestat, join_yd_datestat, join_yd_datestat_smart, join_ym_events                                                                                                                                                                                  | ready      |
| [[get_relations_by_re]] | auxiliary | join_appmetrica_events, join_appmetrica_registry_appprofilematching, join_appsflyer_events, join_mt_datestat, join_sheets_periodstat, join_vkads_datestat, join_utmcraft_registry_utmhashregistry, join_yd_datestat, join_yd_datestat_smart, join_ym_events | ready      |
| [[get_utmhash]]         | auxiliary | join_ym_events                                                                                                                                                                                                                                              | ready      |

## Описание

Этот подвид макроса `join` предназначен для работы с данными источника `ym` (эти данные относятся к пайплайну `events`).

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

Макрос обрабатывает данные источника `ym`. Эти данные относятся к пайплайну `events`.

Для этих данных макрос ищет `relations` при помощи вспомогательного макроса [[get_relations_by_re]], затем создаёт таблицу-источник при помощи вспомогательного макроса `dbt_utils.union_relations`. (Этот макрос из пакета dbt_utils, он не относится к datacraft).

При помощи дополнительного макроса [[get_min_max_date]] в макросе задаются переменные 
`date_from` и `date_to`, которые участвуют в отборе данных.

Далее полученные данные макрос обрабатывает (происходит переименование полей, для некоторых столбцов вводится LowCardinality).

Для внутренней работы макроса также используются вспомогательные макросы [[get_adsourcedirty]] и [[get_utmhash]].

Для этой таблицы задаётся её линк (это будет использоваться на будущих шагах):
- `toLowCardinality('VisitStat') AS __link`

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.

## Пример

Файл в формате sql в папке models. Название файла `join_ym_events`

Содержимое файла:
```sql
-- depends_on: {{ ref('incremental_ym_events_default_yandex_metrika_stream') }}

{{ datacraft.join() }}
```
