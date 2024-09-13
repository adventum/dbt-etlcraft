---
category: main
step: 2_staging
sub_step: 3_hash
doc_status:
---
# macro `hash`

## List of auxiliary macros

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt package"
WHERE file.name != "README" AND contains(in_main_macro, "hash")
SORT doc_status
```


## Summary

The `hash` macro is designed to add hash columns to the data. In the future, these columns will be useful for data deduplication.

## Usage

The name of the dbt model (=the name of the sql file in the models folder) must match the template:
`hash_{pipeline_name}`.

For example, `hash_events`.

A macro is called inside this file:

```sql
{{ etlcraft.hash() }}
```
Above the macro call, the data dependency will be specified in the file via `—depends_on`. That is, the entire contents of the file looks, for example, like this:
```sql
-- depends_on: {{ ref('combine_events') }}

{{ etlcraft.hash() }}
```
## Arguments

This macro accepts the following arguments:
1. `params` (default: none)
2.  `disable_incremental` (default: none)
3. `override_target_model_name` (default: none)
4. `metadata` (default: result of project_metadata() macro)
5. `date_from` (default: none)
6. `date_to` (default: none)
7. `limit0` (default: none)

## Functionality

## Example

A file in sql format in the models folder. File name: 
`hash_events`

File Contents:
```sql
-- depends_on: {{ ref('combine_events') }}

{{ etlcraft.hash() }}
```
## Notes

This is the fifth of the main macros.

**Перевод**

## Описание

Макрос `hash` предназначен для добавления к данным хэш-столбцов. В дальнейшем эти столбцы пригодятся для дедупликации данных.
## Применение

Имя dbt-модели (=имя файла в формате sql в папке models) должно соответствовать шаблону:
`hash_{название_пайплайна}`.

Например, `hash_events`.

Внутри этого файла вызывается макрос:

```sql
{{ etlcraft.hash() }}
```
Над вызовом макроса в файле будет указана зависимость данных через `—depends_on`. То есть целиком содержимое файла выглядит, например, вот так:
```sql
-- depends_on: {{ ref('combine_events') }}

{{ etlcraft.hash() }}
```
## Аргументы

Этот макрос принимает следующие аргументы:

1. `params` (по умолчанию: none)
2.  `disable_incremental` (по умолчанию: none)
3. `override_target_model_name` (по умолчанию: none)
4. `metadata` (по умолчанию: результат макроса project_metadata())
5. `date_from` (по умолчанию: none)
6. `date_to` (по умолчанию: none)
7. `limit0` (по умолчанию: none)

## Функциональность

## Пример

Файл в формате sql в папке models. Название файла `hash_events`

Содержимое файла:
```sql
-- depends_on: {{ ref('combine_events') }}

{{ etlcraft.hash() }}
```

## Примечания

Это пятый из основных макросов.