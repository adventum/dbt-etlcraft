---
category: main
step: 1_silos
sub_step: 1_normalize
doc_status: ready
language: eng
---
# macro `normalize`
## List of auxiliary macros

| Name                                                                         | Category  | In Main Macro          | Doc Status |
| ---------------------------------------------------------------------------- | --------- | ---------------------- | ---------- |
| [[custom_union_relations_source]]                                            | auxiliary | normalize              | ready      |
| [[dbt Package/english_version/get_from_default_dict\|get_from_default_dict]] | auxiliary | normalize              | ready      |
| [[json_extract_string]]                                                      | auxiliary | normalize              | ready      |
| [[normalize_name]]                                                           | auxiliary | normalize              | ready      |
| [[find_incremental_datetime_field]]                                          | auxiliary | normalize, incremental | ready      |
| [[get_relations_by_re]]                                                      | auxiliary | normalize, combine     | ready      |
| [[get_from_default_dict]]                                                    | auxiliary | normalize              | ready      |
| [[dbt Package/english_version/normalize_name\|normalize_name]]               | auxiliary | normalize              | ready      |
| [[dbt Package/english_version/json_extract_string\|json_extract_string]]     | auxiliary | normalize              | ready      |


## Summary

The `normalize` macro is designed to normalize tables that are downloaded by Airbyte.

## Usage

The name of the dbt model (= the name of the sql file in the models folder) must match the template: 
`normalize_{sourcetype_name}_{pipeline_name}_{template_name}_{stream_name}`.

For example, `normalize_appmetrica_events_default_deeplinks`.

A macro is called inside this file like this:
```sql
{{ datacraft.normalize() }}
```
## Arguments

This macro accepts the following arguments:

01. `fields` (required argument is a list of fields)
02. `incremental_datetime_field` (default: none)
03. `incremental_datetime_formula` (default: none)
04. `disable_incremental_datetime_field` (default: none)
05. `default_dist` (default: result of the fieldconfig() macro)
06. `schema_pattern` (default: 'arbyte_internal')
07. `source_table` (default: none)
08. `override_target_model_name` (default: none)
09. `debug_column_names` (default: False)
10. `old_arbyte` (default: True)
11. `limit 0` (default: none)

## Functionality

This macro should start its work after removing dependencies. That is, after the first stage of the project formation has passed - the `dbt parse`, on which the `manifest` is created. After the `manifest` is created, the project will already be able to use internal links - `ref`, which are necessary for dbt models to work.
 
Therefore, the `normalize` macro is wrapped in the `if execute` condition - otherwise its work may be wasted.

First of all, parts of the name are set in the macro - either from the passed argument (`override_target_model_name`), or from the file name (`this.name`). When using the `override_target_model_name` argument, the macro works as if it were in a model with a name equal to the value `override_target_model_name`.

.A long name obtained in one way or another is divided into parts by the underscore character. For example, the name `normalize_appmetrica_events_default_deeplinks` will be split into 5 parts.

If the model name does not match the template (it does not start with `normalize_`, or there are not enough parts in it), the macro does not go further and at this step already outputs an error for the user with a brief description of the problem.

Next, the macro sets the source, pipeline, template, and stream variables. For the example of `normalize_appmetrica_events_default_deeplinks` it will be:
- source - `sourcetype_name` → appmetrica
- pipeline - `pipeline_name` → events
- template - `template_name` → default
- stream - `stream_name` → deeplinks
  
After that, the macro collects a pattern from these parts to search for the corresponding model of tables with “raw” data.  Here is the pattern itself:

 `[^_]+' ~ '_[^_]+_' ~ ' raw__stream_' ~ sourcetype_name ~ '_' ~ template_name ~ '_[^_]+_' ~ stream_name ~ '$"

Values from variables are inserted into it, and as a result, the macro will be able to find, for example, with `normalize_appmetrica_events_default_deeplinks` data from `datacraft_clientname_raw__stream_appmetrica_default_accountid_deeplinks` (because the name of the “raw” data matches the template).

If the pipeline corresponds to the directions `registry` or `periodstat`, then the argument `disable_incremental_datetime_field` is automatically set to `True`. This means that there is no incremental date field in such data, and the macro will not try to search for such a field for this data.

Next, the macro will search for “raw” data for the model in which it is called. The name of the source table with the necessary “raw” data can be set directly when calling the macro - the `source_table` argument is responsible for this. 

If the `source_table` parameter is not set when calling the macro, then we search for `relations` - that is, links to the necessary tables - using our own macro `datacraft.get_relations_by_re`. It is located in the `clickhouse-adapters` file. This macro helps you find all the tables that fit a single template (for example, all the data from `appmetrica` for any project).

Inside this macro there is an argument `schema_pattern`, which can be set when calling the macro `normalize`. If the raw data is in the same schema as the model, then `schema_pattern=target.schema`.If the raw data comes from the new version of Airbyte, then they are written to a separate scheme `airbyte_internal`.Therefore, by default we have `schema_pattern='airbyte_internal` set.

If something is wrong with the search for `relations`, the macro will not go further and will give the user an error describing the problem.
                                                                 
After the necessary “raw” data is found, the macro gathers together all the found tables through the `UNION ALL`. To do this, the macro `datacraft.custom_union_relations_source` is used, into which previously found `relations` are passed.

Next, for those data that does not specify the absence of an incremental field with a date (that is, the arguments `incremental_datetime_formula` and `disable_incremental_datetime_field` are left as default - `none`), the formulas for the field with a date are `incremental_datetime_formula`. The [[get_from_default_dict]] macro is used for the search, into which the `defaults_dict` argument is passed. This argument is set by default as the result of calling another macro - `fieldconfig()`. Thus, by default, everything happens automatically, the user does not need to do anything. But at the same time, the user has the opportunity, if necessary, to influence the behavior of the macro.
  
The macro also sets the `incremental_datetime_field` using the `datacraft` macro `find_incremental_datetime_field()`.

Next, the fields are processed. A list of fields is passed to the input to the `normalize` macro - `fields`. For each element of this list (except for the incremental field with the date), processing takes place - we create an alias macro, making transliteration into English using the macro [[normalize_name]]. 

Using the `datacraft` macro [[json_extract_string]] sets the values of the field names from the Airbyte technical field `"_airbyte_data"` if the `debug_column_names` argument is left as `False` by default. If the argument is `True`, the previously created alias will be taken. The resulting list of fields is sorted alphabetically.

The incremental date field is processed separately - and for all cases its name becomes universal: `__date`. 

If the list of fields turns out to be empty as a result of all transformations, the macro will interrupt its work and give the user a brief description of the error.

The resulting list of fields is then passed to an automatically generated SQL query. All fields are listed in the SELECT block. In addition to the data columns, this request also includes:
- the `__table_name` field (wrapped in toLowCardinality()) - the name of the table from which the data was taken is indicated here
- the field `__emitted_at` (in DateTime format). Depending on the value of the `old_airbyte` argument, the macro will take either the `_airbyte_extracted_at` field (if the value of the argument is `True`, as set by default) or `_airbyte_emitted_at` (if the value is `False`). This field contains information about the time of extraction of raw data.
- the field `__normalized_at` (formed via NOW()). This field contains information about the data normalization time.
  
All data is taken from the previously created `source_table`.
  
If the `limit0` argument is activated (which is set to `none` by default), then LIMIT 0 will be specified at the end of the request.

## Example

A file in sql format in the models folder. File name is: `normalize_appmetrica_events_default_deeplinks`

File Contents:
```sql
{{ datacraft.normalize(
fields=['__clientName','__productName','appmetrica_device_id','city',
'deeplink_url_parameters','event_receive_datetime','google_aid',
'ios_ifa','os_name','profile_id','publisher_name']
) }}
```
## Notes

This is the first of the main macros.
