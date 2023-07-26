{% macro find_incremental_datetime_field(relation, defaults_dict=etlcraft_defaults()) %}
    {%- set model_name_parts = relation.split('_') -%}
    {%- if model_name_parts|length < (6 if model_name_parts[-1] == 'auto' else 4) or model_name_parts[0] != 'normalize' -%}
        {{ exceptions.raise_compiler_error('Relation name "' ~ relation ~ '" does not follow the expected pattern: "{stagename}_{sourcetype}_{templatename}_{streamname}(__auto)?", where suffix "__auto" is optional') }}
    {%- endif -%}
    {%- set source_type = model_name_parts[1] -%}
    {%- set stream_name_parts = model_name_parts[3:-1] if model_name_parts[-1] == 'auto' else model_name_parts[3:] -%}
    {%- set stream_name = '_'.join(stream_name_parts) -%}
    
    {%- set datetime_field = get_from_default_dict(defaults_dict, ['sourcetypes', source_type, 'streams', stream_name, 'datetime_field']) -%}
    {%- if datetime_field == {} -%}
        {%- set datetime_field = get_from_default_dict(defaults_dict, ['sourcetypes', source_type, 'incremental_datetime_field']) -%}
    {%- endif -%}
    
    {%- if datetime_field == {} -%}
        {%- set datetime_columns = [] -%}
        {%- set columns = adapter.get_columns_in_relation(relation) -%}
        {%- for column in columns -%}            
            {%- if  column.name not in ['_emited_at', '_normalized_at'] and (
              column.column.lower().endswith('date') 
              or column.column.lower().endswith('datetime')
              or column.column.lower().endswith('timestamp') 
              or column.data_type.lower().endswith('date') 
              or column.data_type.lower().endswith('datetime')
              or column.data_type.lower().endswith('timestamp')) -%}
                {%- do datetime_columns.append(column.column) -%}
            {%- endif -%}
        {%- endfor -%}
        {%- if datetime_columns|length == 0 -%}
            {{ exceptions.raise_compiler_error('No columns with names or types ending in "date" or "datetime" were found in the relation "' ~ relation ~ '". Please ensure that your source data contains such a column for incremental processing.') }}
        {%- elif datetime_columns|length > 1 -%}
            {{ exceptions.raise_compiler_error('Multiple columns with names or types ending in "date" or "datetime" were found in the relation "' ~ relation ~ '". Please ensure that only one such column is present for incremental processing, or specify the correct one in the defaults dictionary.') }}
        {%- else -%}
            {%- set datetime_field = datetime_columns[0] -%}
        {%- endif -%}
    {%- endif -%}
    
    {{ return(datetime_field) }}
{% endmacro %}



