---
category: main
step: 1_silos
sub_step: 2_incremental
doc_status: ready
language: eng
---
# macro `incremental`

## List of auxiliary macros

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_main_macro, "incremental")
SORT doc_status
```

## Summary

The `incremental` macro is designed to create incremental tables - that is, tables where data is historically accumulated. The basis for this step is the data obtained from the models of the `normalize` step.
## Usage

The name of the dbt model (= the name of the sql file in the models folder) must match the template: 
`incremental_{sourcetype_name}_{pipeline_name}_{template_name}_{stream_name}`.

For example, `incremental_appmetrica_events_default_deeplinks`.

A macro is called inside this file like this:
```sql
{{ etlcraft.incremental() }}
```

From this step onwards, above the macro call, the data dependency will be specified in the file via `—depends_on`. That is, the entire contents of the file looks, for example, like this:
```sql
-- depends_on: {{ ref('normalize_appmetrica_events_default_deeplinks') }}

{{ etlcraft.incremental() }}
```

## Arguments

This macro accepts the following arguments:

1. `defaults_dict` (default: result of the fieldconfig() macro)
2. `disable_incremental` (default: False)
3. `limit0` (default: none)
## Functionality

First, the macro reads the model name through the existing file name (`this.name`).

If the model name does not match the template, the macro will return an error:

`"Model name does not match the expected naming convention: 'incremental_{sourcetype_name}_{pipeline_name}_{template_name}_{stream_name}'."`

Next, the macro splits the model name into parts, and thus receives the source, pipeline, template, and data stream. From this data, the macro collects a pattern, which will then be used to search for the corresponding model from the `normalize` step. This pattern is useful in the FROM section of an SQL query.

Here is the pattern itself:

`'normalize_' ~ sourcetype_name ~ '_' ~ pipeline_name ~ '_' ~ template_name ~ '_' ~ stream_name`

Values from variables are inserted into it, and as a result, the macro will be able to find data from `normalize_appmetrica_events_default_deeplinks` for the example with `incremental_appmetrica_events_default_deeplinks` (because the name of the data model of the `normalize` step corresponds to the template).

If the pipeline corresponds to the directions `registry` or `period stat`, then the argument `disable_incremental_datetime_field` is automatically set to `True`. This means that there is no incremental date field in such data, and the macro will not try to search for such a field for this data.

If the user specified the `disable_incremental` argument when calling the macro if `True`, then the table will not be incremental, it will be a regular table.

In all other cases (including when calling the default macro), the macro will search for an incremental field with a date using the auxiliary macro `find_incremental_datetime_field`.

If the incremental date field is still not set, the materialization will be set as a `table`:

```sql
    {{ config(

        materialized='table',

        order_by=('__table_name'),

        on_schema_change='fail'

    ) }}
```
  
If the incremental field with the date is set, the materialization will be `incremental`:

```sql
    {{ config(

        materialized='incremental',

        order_by=('__date', '__table_name'),

        incremental_strategy='delete+insert',

        unique_key=['__date', '__table_name'],

        on_schema_change='fail'

    ) }}
```
  
Additionally, the macro checks whether there is data in the table of the previous step or that table is empty. The auxiliary macro `check_table_empty` is used for this.

Next, a SELECT query occurs, which takes all the fields from the corresponding previous table, except for the field with the date. This field is replaced by a field processed by the `cast_date_field` macro.

If checking the normalize step table (using the `check_table_empty` macro) showed that this table is not empty, then the macro will take data from it. And if it is empty, then the `incremental` step macro will take data from itself. Why is this necessary? Suppose you update the data on a schedule, but there was no new data in the first step (`normalize`). In this case, the project should not fall with an error, it will be able to go further.

If the `limit 0` argument is activated (which is set to `none` by default), then LIMIT 0 will be specified at the end of the request.
## Example

A file in sql format in the models folder. File name is: `incremental_appmetrica_events_default_deeplinks`

File Contents:
```sql
-- depends_on: {{ ref('normalize_appmetrica_events_default_deeplinks') }}

{{ etlcraft.incremental() }}
```
## Notes

This is the second of the main macros.
