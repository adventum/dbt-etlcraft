---
category: sub_main
step: 2_staging
sub_step: 1_join
in_main_macro: join
doc_status: empty_template
---
# macro `join_appsflyer_events`

## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "join_appsflyer_events")
SORT doc_status
```
## Описание

Этот подвид макроса `join` предназначен для работы с данными источника `appsflyer` (они относятся к пайплайну `events`).

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

## Пример

Файл в формате sql в папке models. Название файла `join_appsflyer_events`

Содержимое файла:
```sql
-- depends_on: {{ ref('incremental_appsflyer_events_default_in_app_events') }}

{{ etlcraft.join() }}
```
