---
category: main
step: 4_graph
sub_step: 
doc_status:
---
# macro `graph`

## List of auxiliary macros

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_main_macro, "LOOK HERE")
SORT doc_status
```

## Описание

Макрос `graph` предназначен для графовой склейки данных. Он реализуется в несколько шагов:
- graph_tuples
- graph_lookup
- graph_unique
- graph_edge
- graph_glue
- graph_qid
## Применение

Имя dbt-модели (=имя файла в формате sql в папке models) должно соответствовать шаблону:
`graph_{название_шага}`.

Например, `graph_tuples`.

Внутри этого файла вызывается макрос:

```sql
{{ etlcraft.graph() }}
```
Над вызовом макроса в файле будет указана зависимость данных через `—depends_on`. То есть целиком содержимое файла выглядит, например, вот так:
```sql
-- depends_on: {{ ref('link_events') }}

{{ etlcraft.graph() }}
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