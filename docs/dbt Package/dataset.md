---
category: main
step: 7_dataset
sub_step: 
doc_status: empty_template
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

## Usage

The name of the dbt model (=the name of the sql file in the models folder) must match the template:
`NAME_{pipeline_name}`.

For example, `NAME`.

A macro is called inside this file:

```sql
{{ etlcraft.NAME() }}
```
Above the macro call, the data dependency will be specified in the file via `—depends_on`. That is, the entire contents of the file looks, for example, like this:
```sql
SOMETHING
```
## Arguments

This macro accepts the following arguments:

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

Макрос `[macro]` предназначен для 
## Применение

Имя dbt-модели (=имя файла в формате sql в папке models) должно соответствовать шаблону:
`MACRO_{название_источника}_{название_пайплайна}_{название_шаблона}_{название_потока}`.

Например, `MACRO_NAME`.

Внутри этого файла вызывается макрос:

```sql
{{ etlcraft.MACRO() }}
```
Над вызовом макроса в файле будет указана зависимость данных через `—depends_on`. То есть целиком содержимое файла выглядит, например, вот так:
```sql
-- depends_on: {{ ref('SOMETHING') }}

{{ etlcraft.MACRO() }}
```
## Аргументы

Этот макрос принимает следующие аргументы:

## Функциональность

## Пример

Файл в формате sql в папке models. Название файла `[NAME]`

Содержимое файла:
```sql
SOMETHING INSIDE
```

## Примечания

Это N-й из основных макросов.