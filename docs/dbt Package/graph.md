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
WHERE file.name != "README" AND contains(in_main_macro, "graph")
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

1. `params` (по умолчанию: none)
2. `override_target_model_name` (по умолчанию: none)
3. `limit0` (по умолчанию: none)
## Функциональность

Технически сам макрос `graph` - регулировщик. Он направляет работу под-макросов типа `graph_` по шагам. 

Под-макросами являются:
1. graph_tuples
2. graph_lookup
3. graph_unique
4. graph_edge
5. graph_glue
6. graph_qid

Кроме них, есть ещё вспомогательный макрос `calc_graph`, который используется на шагах `graph_glue` и `graph_qid`.

Технически действие самого макроса `graph`(регулировщика) реализуется так: 

сначала макрос считает имя модели - либо из передаваемого аргумента (  
`override_target_model_name`), либо из имени файла (`this.name`). При использовании аргумента `override_target_model_name` макрос работает так, как если бы находился в модели с именем, равным значению `override_target_model_name`.

Затем макрос вызывает нужный шаг макроса `graph` в зависимости от считанного имени модели.

## Пример

Файл в формате sql в папке models. Название файла `graph_tuples`

Содержимое файла:
```sql
-- depends_on: {{ ref('link_events') }}

{{ etlcraft.graph() }}
```

## Примечания

Это седьмой из основных макросов.