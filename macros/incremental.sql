/* Write dbt macro "incremental"  that works similarly to "normalize". This time the pattern of this.model name must be incremental_{sourcetypename}_{templatename}_{streamname} with optional suffix __auto. It finds a table with prefix normalize_{sourcetypename}_{templatename}_{streamname} and makes select * from it.
Also it determines the main datetime field of the table. It can be taken from optional argument datetime_field of the macro. If the argument is not provided, it looks through the field list of the table and 
Before the query place  {{ config() }} part, where specify the following properties
materialized = 'incremental'
order_by=('event_datetime', '_table_name')
*/
{%- macro get_date_field(relation, defaults_dict=etlcraft_defaults()) -%}
{%- set relation_parts = relation.split('_') -%}
{%- if relation_parts|length < (6 if relation_parts[-1] == 'auto' else 4) -%}
    {{ exceptions.raise_compiler_error('Relation name "' ~ relation ~ '" does not follow the expected pattern: "{stagename}_{sourcetypename}_{templatename}_{streamname}(__auto)?", where suffix is "auto" is optional') }}
{%- endif -%}
{%- set source_type = relation_parts[1] -%}
{%- set stream_name_parts = relation_parts[3:-1] if relation_parts[-1] == 'auto' else relation_parts[3:] -%}
{%- set stream_name = '_'.join(stream_name_parts) -%}

{%- set datetime_field = defaults_dict.get('sourcetypes', {}).get(source_type, {}).get('streams', {}).get(stream_name, {}).get('datetime_field', '') -%}
{%- if datetime_field != '' -%}
    {{ return(datetime_field) }}
{%- endif -%}

{%- set datetime_field = defaults_dict.get('sourcetypes', {}).get(source_type, {}).get('datetime_field', '') -%}
{%- if datetime_field != '' -%}
    {{ return(datetime_field) }}
{%- endif -%}

{%- set columns = adapter.get_columns_in_relation(this) -%}

{%- if date_fields|length == 0 -%}
    {{ exceptions.raise_compiler_error('No field with data type ending with "date" or "datetime" was found in the relation "' ~ relation ~ '". Please check the data structure.') }}
{%- elif date_fields|length > 1 -%}
    {{ exceptions.raise_compiler_error('Multiple fields with data type ending with "date" or "datetime" were found in the relation "' ~ relation ~ '". Please specify which one to use.') }}
{%- else -%}
    {{ return(date_fields[0]) }}
{%- endif -%}
{%- endmacro -%}
