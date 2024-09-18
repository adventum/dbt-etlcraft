---
category: main
step: 6_attribution
sub_step: 
doc_status: empty_template
language: rus
---
# macro `[macro_name]`

## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt package"
WHERE file.name != "README" AND contains(in_main_macro, "LOOK HERE")
SORT doc_status
```

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