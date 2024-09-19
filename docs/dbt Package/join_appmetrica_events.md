---
category: sub_main
step: 2_staging
sub_step: 1_join
in_main_macro: join
doc_status: ready
---
# macro `join_appmetrica_events`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "join_appmetrica_events")
SORT doc_status
```


## Описание

Подвид макроса `join`. Этот подвид макроса предназначен для работы с данными источника `appmetrica`, которые относятся к пайплайну `events`.

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

Макрос объединяет данные разных стримов, относящихся к источнику `appmetrica` и к пайплайну `events`.

Для каждого стрима макрос ищет `relations` при помощи вспомогательного макроса [[get_relations_by_re]], затем создаёт таблицу-источник при помощи вспомогательного макроса `dbt_utils.union_relations`. (Этот макрос из пакета dbt_utils, он не относится к etlcraft).

Далее для каждого стрима макрос создаёт его CTE (`common table expression`) с одинаковым набором полей и их расположением.

Стримы:
1. `deeplinks` 
2. `events`
3. `install`
4. `screen_view`
5. `sessions_starts`

Для каждого стрима задаётся его линк (это будет использоваться на будущих шагах). Вот какие это значения - перечисление в соответствии с порядком стримов:
1. `toLowCardinality('AppDeeplinkStat') AS __link`
2. `toLowCardinality('AppEventStat') AS __link`
3. `toLowCardinality('AppInstallStat') AS __link`
4. `toLowCardinality('AppEventStat') AS __link`
5. `toLowCardinality('AppSessionStat') AS __link`

После формирования всех `CTE` происходит их объединение через `UNION ALL`. 

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.
## Пример

Файл в формате sql в папке models. Название файла `join_appmetrica_events`

Содержимое файла:
```sql
-- depends_on: {{ ref('incremental_appmetrica_events_default_deeplinks') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_events') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_installations') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_screen_view') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_sessions_starts') }}

{{ etlcraft.join() }}
```
