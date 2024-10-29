---
category: main
step: 2_staging
sub_step: 2_combine
doc_status: ready
language: eng
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
{{ datacraft.combine() }}
```
Above the macro call, the data dependency will be specified in the file via `—depends_on`. That is, the entire contents of the file looks, for example, like this:
```sql
-- depends_on: {{ ref('join_appmetrica_events') }}

-- depends_on: {{ ref('join_ym_events') }}

{{ datacraft.combine() }}
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

{{ datacraft.combine() }}
```
## Notes

This is the fourth of the main macros.
