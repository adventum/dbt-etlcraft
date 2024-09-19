---
category: main
step: 6_attribution
sub_step: 
doc_status: empty_template
language: rus
---
# macro `attr`

## Список используемых вспомогательных макросов

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_main_macro, "attr")
SORT sub_step, doc_status
```

## Описание

Макрос `attr` предназначен для подготовки и анализа данных для атрибуции. Он реализуется в несколько шагов:
1. [[attr_prepare_with_qid]]
2. [[attr_create_events]]
3. [[attr_add_row_number]]
4. [[attr_find_new_period]]
5. [[attr_calculate_period_number]]
6. [[attr_create_missed_steps]]
7. [[attr_join_to_attr_prepare_with_qid]]
8. [[attr_model]]
9. [[attr_final_table]]
## Применение

Имя dbt-модели (=имя файла в формате sql в папке models) должно соответствовать шаблону:
`attr_{название_воронки}_{название_шага}`.

Например, `attr_myfirstfunnel_prepare_with_qid`.

Внутри этого файла вызывается макрос:

```sql
{{ etlcraft.attr() }}
```
Над вызовом макроса в файле будет указана зависимость данных через `—depends_on`. То есть целиком содержимое файла выглядит, например, вот так:
```sql
-- depends_on: {{ ref('full_events') }}

-- depends_on: {{ ref('graph_qid') }}

{{ etlcraft.attr() }}
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