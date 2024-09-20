---
category: sub_main
step: 2_staging
sub_step: 1_join
in_main_macro: join
doc_status: empty_template
---
# macro `join_utmcraft_registry_utmhashregistry`

## ## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_sub_main_macro AS "In Sub-Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_sub_main_macro, "join_utmcraft_registry_utmhashregistry")
SORT doc_status
```
## Описание

Этот подвид макроса `join` предназначен для работы с данными источника `utmcraft` (данные относятся к пайплайну `registry`).

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

Файл в формате sql в папке models. Название файла `join_utmcraft_registry_utmhashregistry`

Содержимое файла:
```sql
-- depends_on: {{ ref('incremental_utmcraft_registry_default_utmresult') }}

{{ etlcraft.join(disable_incremental=True) }}
```
