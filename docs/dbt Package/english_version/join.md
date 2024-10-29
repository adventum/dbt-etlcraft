---
category: main
step: 2_staging
sub_step: 1_join
doc_status: ready
language: eng
---
# macro `join`

## List of auxiliary macros

```dataview
TABLE 
category AS "Category", 
in_main_macro AS "In Main Macro",
doc_status AS "Doc Status"
FROM "dbt Package"
WHERE file.name != "README" AND contains(in_main_macro, "join")
SORT doc_status
```

## Summary

The `join` macro is designed to connect different data streams from the same source.

## Usage

The name of the dbt model (=the name of the sql file in the models folder) must match the template:
`join_{source name}_{pipeline name}`.

For example, `join_appmetrica_events`.

A macro is called inside this file:

```sql
{{ datacraft.join() }}
```
Above the macro call, the data dependency will be specified in the file via `—depends_on`. That is, the entire contents of the file looks, for example, like this:
```sql
-- depends_on: {{ ref('incremental_appmetrica_events_default_deeplinks') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_events') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_installations') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_screen_view') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_sessions_starts') }}

{{ datacraft.join() }}
```
Technically  `join` macro is a traffic controller. Since the data in different sources is organized differently, each source will have its own kind of macro `join`, inside which the main work with the data takes place.

For example, the `join` macro redirects data from the `appmetrica` source to the `join_appmetrica_events` macro, and data from the `ym` source to the `join_ym_events` macro.

If you have your own data source, or you need to tweak something in the code for yourself - this is done here, at the `join` step, inside the `join` sub-macro for your source.

## Arguments

This macro accepts the following arguments:
1. `params` (default: none)
2. `disable_incremental` (default: none)
3. `override_target_model_name` (default: none)
4. `date_from` (default: none)
5. `date_to` (default: none)
6. `limit 0` (default: none)
## Functionality

First, the macro considers the name of the model from the passed argument (
`override_target_model_name`), or from the file name (`this.name`). When using the `override_target_model_name` argument, the macro works as if it were in a model with a name equal to the value `override_target_model_name`.

The name of the model, obtained in one way or another, is divided into parts by the underscore. For example, the name `join_appmetrica_events` will be split into 3 parts, and the macro will take over from these parts:
- source - `sourcetype_name` → appmetrica
- pipeline - `pipeline_name` → events

For some models, for example, for `join_appmetrica_registry_appprofilematching`,
the macro will take more:
- link - `link_name` →appprofilematching

If the pipeline corresponds to the directions `registry` or `periodstat`, then the `disable_incremental` argument is automatically set to `True`. This means that there is no incremental date field in such data.

Next, the macro generates the name of the join macro to redirect this data to.
  
If the pipeline is not a `registry`, then the pattern will be like this:

`'join_'~ sourcetype_name ~'_'~ pipeline_name`

For the pipeline `registry` data, the pattern will be slightly longer:

`'join_'~ sourcetype_name ~'_'~ pipeline_name ~ '_' ~ link_name`

Additionally, a distinction is being introduced for two types of yandex direct - with and without smart campaigns (they will be processed separately).

When the name of the macro to redirect the data to is determined, the join macro calls it.
## Example

A file in sql format in the models folder. File name: 
`join_appmetrica_events`

File Contents:
```sql
-- depends_on: {{ ref('incremental_appmetrica_events_default_deeplinks') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_events') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_installations') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_screen_view') }}

-- depends_on: {{ ref('incremental_appmetrica_events_default_sessions_starts') }}

{{ datacraft.join() }}
```
## Notes

This is the third of the main macros.
