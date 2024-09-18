---
category: main
step: 5_full
sub_step: 
doc_status: empty_template
---
# macro `full`

## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_main_macro, "full")
SORT doc_status
```

## Описание

Макрос `full` предназначен для объединения данных пайплайна с `registry`-таблицами. В зависимости от пайплайна поведение макроса меняется.
## Применение

Имя dbt-модели (=имя файла в формате sql в папке models) должно соответствовать шаблону:
`full_{название_пайплайна}`.

Например, `full_events`.

Внутри этого файла вызывается макрос:

```sql
{{ etlcraft.full() }}
```
Над вызовом макроса в файле будет указана зависимость данных через `—depends_on`. То есть целиком содержимое файла выглядит, например, вот так:
```sql
-- depends_on: {{ ref('graph_qid') }}

-- depends_on: {{ ref('link_events') }}

-- depends_on: {{ ref('link_registry_appprofilematching') }}

-- depends_on: {{ ref('link_registry_utmhashregistry') }}

{{ etlcraft.full() }}
```
## Аргументы

Этот макрос принимает следующие аргументы:
 
1. `params` (по умолчанию: none)
2.  `disable_incremental` (по умолчанию: none)
3. `override_target_model_name` (по умолчанию: none)
4. `date_from` (по умолчанию: none)
5. `date_to` (по умолчанию: none)
6. `limit0` (по умолчанию: none)
7. `metadata` (по умолчанию: результат макроса `project_metadata()`)
## Функциональность

## Пример

Файл в формате sql в папке models. Название файла `full_events`

Содержимое файла:
```sql
-- depends_on: {{ ref('graph_qid') }}

-- depends_on: {{ ref('link_events') }}

-- depends_on: {{ ref('link_registry_appprofilematching') }}

-- depends_on: {{ ref('link_registry_utmhashregistry') }}

{{ etlcraft.full() }}
```

## Примечания

Это восьмой из основных макросов.