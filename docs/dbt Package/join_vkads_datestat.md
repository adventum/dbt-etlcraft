---
category: sub_main
step: 2_staging
sub_step: 1_join
in_main_macro: join
doc_status: ready
---
# macro `join_vkads_datestat`

## Список используемых вспомогательных макросов

| Name                    | Category  | In Sub-Main Macro                                                                                                                                                                                                                                           | Doc Status |
| ----------------------- | --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- |
| [[get_relations_by_re]] | auxiliary | join_appmetrica_events, join_appmetrica_registry_appprofilematching, join_appsflyer_events, join_mt_datestat, join_sheets_periodstat, join_vkads_datestat, join_utmcraft_registry_utmhashregistry, join_yd_datestat, join_yd_datestat_smart, join_ym_events | ready      |

## Описание

Этот подвид макроса `join` предназначен для работы с данными источника `vkads` (данные  относятся к пайплайну `datestat`).

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

Макрос объединяет данные разных стримов, относящихся к источнику `vkads`.

Стримы:
- `ad_plans_statistics`
- `ad_plans`

Для каждого стрима макрос ищет `relations` при помощи вспомогательного макроса [[get_relations_by_re]], затем создаёт таблицу-источник при помощи вспомогательного макроса `dbt_utils.union_relations`. (Этот макрос из пакета dbt_utils, он не относится к datacraft).

При помощи дополнительного макроса [[get_min_max_date]] в макросе задаются переменные 
`date_from` и `date_to`, которые участвуют в отборе данных.

Далее полученные данные из этих стримов соединяются (джойнятся) по id:
```sql
ad_plans.id = ad_plans_statistics.ad_plan_id
```

Для этой таблицы задаётся её линк (это будет использоваться на будущих шагах):
- `toLowCardinality('AdCostStat') AS __link`

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.
## Пример

Файл в формате sql в папке models. Название файла `join_vkads_datestat`

Содержимое файла:
```sql
-- depends_on: {{ ref('incremental_vkads_datestat_default_ad_plans_statistics') }}

-- depends_on: {{ ref('incremental_vkads_registry_default_ad_plans') }}

{{ datacraft.join() }}
```
