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

## Usage

## Arguments

This macro accepts the following arguments:

## Functionality

## Example
## Notes

**Перевод**

## Описание

Макрос `combine` предназначен для объединения данных одного пайплайна в одну модель.
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