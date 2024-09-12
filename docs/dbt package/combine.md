---
category: main
step: 2_staging
sub_step: 2_combine
doc_status:
---
# macro `[macro_name]`

## List of auxiliary macros

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt package"
WHERE file.name != "README" AND contains(in_main_macro, "LOOK HERE")
SORT doc_status
```


## Summary

The `combine` macro is designed to combine data for each pipeline.
## Usage

The name of the dbt model (=the name of the sql file in the models folder) must match the template:
`combine_{pipeline_name}`.

For example, `combine_events`.

A macro is called inside this file:

```sql
{{ etlcraft.combine() }}
```
Above the macro call, the data dependency will be specified in the file via `—depends_on`. That is, the entire contents of the file looks, for example, like this:
```sql
-- depends_on: {{ ref('join_appmetrica_events') }}

-- depends_on: {{ ref('join_ym_events') }}

{{ etlcraft.combine() }}
```
## Arguments

This macro accepts the following arguments:
1. params (default: none)
2. disable_incremental (default: none)
3. override_target_model_name (default: none)
4. date_from (default: none)
5. date_to (default: none)
6. limit 0 (default: none)
## Functionality

## Example

A file in sql format in the models folder. File name: 
`NAME`

File Contents:
```sql
-- depends_on: {{ ref('SOMETHING') }}


{{ etlcraft.MACRO() }}
```
## Notes

This is the … of the main macros.

**Перевод**

## Описание

Макрос `combine` предназначен для объединения данных по каждому пайплайну.
## Применение

Имя dbt-модели (=имя файла в формате sql в папке models) должно соответствовать шаблону:
`combine_{название_пайплайна}`.

Например, `combine_events`.

Внутри этого файла вызывается макрос:

```sql
{{ etlcraft.combine() }}
```
Над вызовом макроса в файле будет указана зависимость данных через `—depends_on`. То есть целиком содержимое файла выглядит, например, вот так:
```sql
-- depends_on: {{ ref('join_appmetrica_events') }}

-- depends_on: {{ ref('join_ym_events') }}

{{ etlcraft.combine() }}
```
## Аргументы

Этот макрос принимает следующие аргументы:

1. params (по умолчанию: none)
2.  disable_incremental (по умолчанию: none)
3. override_target_model_name (по умолчанию: none)
4. date_from (по умолчанию: none)
5. date_to (по умолчанию: none)
6. limit0 (по умолчанию: none)
## Функциональность

## Пример

Файл в формате sql в папке models. Название файла: 
`combine_events`

Содержимое файла:
```sql
-- depends_on: {{ ref('join_appmetrica_events') }}

-- depends_on: {{ ref('join_ym_events') }}

{{ etlcraft.combine() }}
```

## Примечания

Это четвёртый из основных макросов.