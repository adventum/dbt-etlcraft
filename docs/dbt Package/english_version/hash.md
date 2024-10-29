---
category: main
step: 2_staging
sub_step: 3_hash
doc_status: ready
language: eng
---
# macro `hash`

## List of auxiliary macros

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
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
{{ datacraft.hash() }}
```
Above the macro call, the data dependency will be specified in the file via `—depends_on`. That is, the entire contents of the file looks, for example, like this:
```sql
-- depends_on: {{ ref('combine_events') }}

{{ datacraft.hash() }}
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

First, the macro considers the name of the model from the passed argument (  
`override_target_model_name`), or from the file name (`this.name`). When using the `override_target_model_name` argument, the macro works as if it were in a model with a name equal to the value `override_target_model_name`.

The name of the model, obtained in one way or another, is divided into parts by the underscore. For example, the name `hash_events` will be split into 2 parts, and the macro will take over from these parts:

- pipeline - `pipeline_name` → events

For the pipeline `registry`, the macro will also take link.
If the pipeline refers to `datestat` or `events`, then the materialization will be incremental:

```sql
{{ config(

    materialized='incremental',

    order_by=('__date', '__table_name'),

    incremental_strategy='delete+insert',

    unique_key=['__date', '__table_name'],

    on_schema_change='fail'

) }}
```
In other cases, the usual:

```sql
{{ config(

    materialized='table',

    order_by=('__table_name'),

    on_schema_change='fail'

) }}
```
If the model name does not match the template, the macro will return an error.

Next, the macro will set a pattern to find the combine table of the desired pipeline.
The pattern for the pipeline `registry`:

`'combine_' ~ pipeline_name ~'_'~ link_name`

For other pipelines:

`'combine_' ~ pipeline_name`

Next, the macro will work with `metadata`.

The names of all project links will be selected from the metadata. For each link, data on it will be received - `pipeline`, `datetime_field`, `main_entities`, `other_entities`.

Next, such entities will be selected for which either the condition `glue=yes`, or this entity is included in the `main_entities`. Entities are selected according to these two conditions, then the resulting list becomes unique.

From the unique list of entities, we select those that are either in the list of entities `glue='yes'`, or it is in the `registry` section.

For the pipeline `registry` models, we select links and entities separately in order to output models separately for each data source.

For example, the pipeline model `registry` has link A in the name - the macro goes to the metadata and selects all the information on this link A. For a model with a different link - B - the macro will select information on link B. 

Next, all previously obtained data will be used for generating an SQL query.

The macro accesses the source table previously found using the pattern and takes data from there. The macro adds: 
- hashes for selected **links** using the `link_hash` macro 
- hashes for selected **entities** using the macro `entity_hash`
  
Then, based on this data, the `__id` field and the `__datetime` field are formed. 
To create the `__id` field, the macro iterates through the selected links, and when it finds one that matches the value in the `__link` field (this field and its value are set at the `join` step), it creates a `__id` from this link.

```sql

SELECT *,

  assumeNotNull(CASE

{%- for link in links_list %}

    {%- set link_hash = link ~ 'Hash' %}  

    WHEN __link = '{{link}}'

    THEN {{link_hash}}

{% endfor %}

    END) as __id
```
In order to form the `__datetime` field, the macro looks at the metadata. If there is a `datetime_field` field from the metadata for the selected link, then the macro converts it to the date format. If there is no such field in the metadata, the macro will convert the default field to the date format through the additional macro `zero_date`.

If the argument is `limit0` if activated, then `LIMIT 0` will be added at the end of the SQL query.

Also at the end of this macro there is an additional setting to improve performance that can be activated (by default it is in a commented form):

```
```sql 
 --SETTINGS short_circuit_function_evaluation=force_enable
```

## Example


A file in sql format in the models folder. File name: 
`hash_events`

File Contents:
```sql
-- depends_on: {{ ref('combine_events') }}

{{ datacraft.hash() }}
```
## Notes

This is the fifth of the main macros.
