/* normalize -- a dbt macros that normalizes tables downloaded by Airbyte.

The behaviour of the macros depends of the name of them model. The model name must follow the pattern
normalize_{sourcetypename}_{templatename}_{streamname} with optional suffix _auto.
Macros extracts sourcetypename, templatename and streamname, and makes union of the tables
_airbyte_{sourcetypename}_%_{templatename}_{streamname}. 

Macros utilizes dtb_utils.union(dbt_utils.get_relations_by_pattern(schema_pattern, table_pattern)))
to get all the relevant tables. schema_pattern is the name of the current schema and table_pattern is as above.

These tables contains columns _airbyte_ab_id, _airbyte_data and _airbyte_emited_at. _airbyte_data
is a JSON field that contains the data to be normalized. Macros looks at the first line of the first 
column and detects the list of keys in the JSON field.

Then macros iterates over that list and for each adds a line to a column list of the SELECT query to be returned. that extracts the corresponding value from JSON as a column and names. It names
The generated line uses macros json_extract_string(_airbyte_emited_ad, {key_name}) that get the correspoding 
key from the JSON field. Also it contains AS expression, that name the column as the {key_name}, but
after transofmation macros normalize_name(key_name) that removes spaces, transliterates Cyrillic symbols, etc.
*/
{%- macro normalize() -%}
{%- if execute -%}
    {%- set model_name_parts = this.name.split('_') -%}
    {%- if model_name_parts|length < 5 or model_name_parts[0] != 'normalize' or (model_name_parts[-1] != 'auto' and model_name_parts[-1] != 'manual') -%}
        {{ exceptions.raise_compiler_error('Model name "' ~ this.name ~ '" does not follow the expected pattern: "normalize_{sourcetype}_{templatename}_{streamname}(__auto)?", where suffix is "auto" is optional') }}
    {%- endif -%}
    {%- set source_type = model_name_parts[1] -%}
    {%- set template_name = model_name_parts[3] -%}
    {%- set stream_name_parts = model_name_parts[4:-2] if model_name_parts[-1] == 'auto' else model_name_parts[4:] -%}
    {%- set stream_name = '_'.join(stream_name_parts) -%}
    {%- set schema_pattern = this.schema -%}
    {%- set table_pattern = '_airbyte_raw_' ~ source_type ~ '_%_' ~ template_name ~ '_' ~ stream_name -%}
    {%- set relations = dbt_utils.get_relations_by_pattern(schema_pattern=target.schema, 
                                                          table_pattern=table_pattern) -%}
    {%- if relations|length < 1 -%}
        {{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern ~ '". Please ensure that your source data follows the expected structure.') }}
    {%- endif -%}
    {%- set unioned_tables = dbt_utils.union_relations(relations) -%}    
    {%- set json_keys = fromjson(run_query('SELECT ' ~ json_list_keys('_airbyte_data') ~ ' FROM ' ~ unioned_tables ~ ' LIMIT 1').columns[0].values()[0])  -%}    
    {%- set column_list = [] -%}
    {%- for key in json_keys -%}
        {%- do column_list.append(json_extract_string('_airbyte_data', key) ~ " AS " ~ normalize_name(key)) -%}
    {%- endfor -%}
    SELECT
        _dbt_source_relation,
        _airbyte_ab_id, 
        _airbyte_emitted_at,
        {{ column_list|join(', \n') }}
    FROM {{ unioned_tables }}
{%- endif -%}
{%- endmacro -%}