---
category: main
step: 2_staging
sub_step: 2_combine
doc_status: ready + eng
---
# macro `combine`

## List of auxiliary macros

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_main_macro, "combine")
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
1. `params` (default: none)
2. `disable_incremental` (default: none)
3. `override_target_model_name` (default: none)
4. `date_from` (default: none)
5. `date_to` (default: none)
6. `limit0` (default: none)
## Functionality

First, the macro considers the name of the model from the passed argument (
`override_target_model_name`), or from the file name (`this.name`). When using the `override_target_model_name` argument, the macro works as if it were in a model with a name equal to the value `override_target_model_name`.

The name of the model, obtained in one way or another, is divided into parts by the underscore. For example, the name `combine_events` will be split into 2 parts, and the macro will take over from these parts:
- pipeline - `pipeline_name` → events

The models of the `combine` step can have names of 2 or 3 parts, the second part is always a pipeline.

If the model belongs to the pipeline `registry`, then it still has a link. For example, for the `combine_registry_appprofilematching` model there is:
- link - `link_name` → appprofilematching

If the model name does not match the template, the macro will return an error.

Next, the macro will search for the pattern of the corresponding tables from the previous step (`join`).
 
 The pattern for the pipeline `registry` is:

`'join' ~ '_[^_]+_' ~ pipeline_name ~ '_' ~ link_name`

For all other data, the pattern is:

`'join' ~ '_[^_]+_' ~ pipeline_name`

The macro finds all the relevant tables thanks to the work of another macro - `get_relations_by_re`.

If no data is found, the macro will return an error.

Then the received data will be automatically combined (`UNION ALL`) using the macro `custom_union_relations`. This will form the source table - `source_table`.

If the data belongs to the pipelines `datestat` or `events`, then the materialization of the table will be incremental:

```sql
  {{ config(

      materialized='incremental',

      order_by=('__date', '__table_name'),

      incremental_strategy='delete+insert',

      unique_key=['__date', '__table_name'],

      on_schema_change='fail'

  ) }}
```

For other pipelines, the materialization will be different:

```sql
  {{ config(

      materialized='table',

      order_by=('__table_name'),

      on_schema_change='fail'

  ) }}
```
In an automatically generated SQL query, all columns from the previously created `source_table` will be selected in the SELECT block. The `table_name` column will be wrapped in `LowCardinality` to improve performance.

If the `limit0` argument is enabled, `LIMIT 0` will be added at the end of the SQL query.
## Example

A file in sql format in the models folder. File name: 
`combine_events`

File Contents:
```sql
-- depends_on: {{ ref('join_appmetrica_events') }}

-- depends_on: {{ ref('join_ym_events') }}

{{ etlcraft.combine() }}
```
## Notes

This is the fourth of the main macros.

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

1. `params` (по умолчанию: none)
2.  `disable_incremental` (по умолчанию: none)
3. `override_target_model_name` (по умолчанию: none)
4. `date_from` (по умолчанию: none)
5. `date_to` (по умолчанию: none)
6. `limit0` (по умолчанию: none)
## Функциональность

Сначала макрос считает имя модели - либо из передаваемого аргумента (
`override_target_model_name`), либо из имени файла (`this.name`). При использовании аргумента `override_target_model_name` макрос работает так, как если бы находился в модели с именем, равным значению `override_target_model_name`.

Название модели, полученное тем или иным способом, разбивается на части по знаку нижнего подчёркивания. Например, название `combine_events` разобьётся на 2 части, из этих частей макрос возьмёт в работу:
- пайплайн - `pipeline_name` → events

Модели шага `combine` могут иметь названия из 2 или 3 частей, вторая часть всегда пайплайн.

Если модель относится к пайплайну `registry`, то у неё ещё есть линк. Например, для модели `combine_registry_appprofilematching` есть:
- линк - `link_name` → appprofilematching

Если имя модели не соответствует шаблону - макрос выдаст ошибку.

Далее макрос будет искать по паттерну соответствующие ему таблицы из предыдущего шага (`join`).
 
 Паттерн для пайплайна `registry`:

`'join' ~ '_[^_]+_' ~ pipeline_name ~ '_' ~ link_name`

для всех остальных данных паттерн:

`'join' ~ '_[^_]+_' ~ pipeline_name`

Макрос находит все соответствующие таблицы благодаря работе другого макроса - `get_relations_by_re`.

Если никакие данные не будут найдены, макрос выдаст ошибку.

Далее полученные данные автоматически объединятся (`UNION ALL`) при помощи макроса `custom_union_relations`. Таким образом сформируется таблица-источник - `source_table`.

Если данные относятся к пайплайнам `datestat` или `events`, то материализация таблицы будет инкрементальной:

```sql
  {{ config(

      materialized='incremental',

      order_by=('__date', '__table_name'),

      incremental_strategy='delete+insert',

      unique_key=['__date', '__table_name'],

      on_schema_change='fail'

  ) }}
```

Для других пайплайнов материализация будет другой:

```sql
  {{ config(

      materialized='table',

      order_by=('__table_name'),

      on_schema_change='fail'

  ) }}
```
В автоматически генерируемом SQL-запросе в блоке SELECT будут выбраны все столбцы из ранее созданной `source_table`. Столбец `table_name` будет обёрнут в `LowCardinality` для улучшения производительности.

Если аргумент `limit0` активирован, то в конце SQL-запроса будет добавлено `LIMIT 0`.

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