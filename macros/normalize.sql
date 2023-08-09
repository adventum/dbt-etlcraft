{%- macro normalize(included_fields=[], excluded_fields=[], 
    defaults_dict=etlcraft_defaults(), schema_pattern=this.schema, source_table=none, override_target_model_name=None) -%}
{%- if execute -%}
    {%- set model_name_parts = (override_target_model_name or this.name).split('_') -%}
    {%- if model_name_parts|length < 5 or model_name_parts[0] != 'normalize' -%}
        {{ exceptions.raise_compiler_error('Model name "' ~ this.name ~ '" does not follow the expected pattern: "normalize_{sourcetype}_{templatename}_{streamname}"') }}
    {%- endif -%}
    {%- set source_type = model_name_parts[1] -%}
    {%- set template_name = model_name_parts[3] -%}
    {%- set stream_name_parts = model_name_parts[4:] -%}
    {%- set stream_name = '_'.join(stream_name_parts) -%}
    {%- set table_pattern = '_airbyte_raw_' ~ source_type ~ '_%_' ~ template_name ~ '_' ~ stream_name -%}

    {%- if source_table is none -%}
        {%- set relations = dbt_utils.get_relations_by_pattern(schema_pattern=target.schema, 
                                                              table_pattern=table_pattern) -%}
        {%- if relations|length < 1 -%}
            {{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern ~ '". Please ensure that your source data follows the expected structure.') }}
        {%- endif -%}
        {%- set source_table = dbt_utils.union_relations(relations) -%}    
    {%- endif -%}
    
    {%- set json_keys = fromjson(run_query('SELECT ' ~ json_list_keys('_airbyte_data') ~ ' FROM ' ~ source_table ~ ' LIMIT 1').columns[0].values()[0])  -%}    
    {%- set default_included_fields = [] -%}
    {%- set default_excluded_fields = [] -%}
    {%- set default_included_fields = get_from_default_dict(defaults_dict, ['sourcetypes', source_type, 'included_fields'], []) -%}
    {%- set default_excluded_fields = get_from_default_dict(defaults_dict, ['sourcetypes', source_type, 'excluded_fields'], []) -%}        
    {%- set default_included_fields = default_included_fields + get_from_default_dict(defaults_dict, ['sourcetypes', source_type, 'streams', stream_name, 'included_fields'], []) -%}
    {%- set default_excluded_fields = default_excluded_fields + get_from_default_dict(defaults_dict, ['sourcetypes', source_type, 'streams', stream_name, 'excluded_fields'], []) -%}    
    {%- set column_set = set(json_keys).union(set(included_fields)).union(set(default_included_fields)).difference(set(excluded_fields)).difference(set(default_excluded_fields)) -%}
    {%- set column_list = [] -%}
    {%- for key in column_set -%}
        {%- do column_list.append(json_extract_string('_airbyte_data', key) ~ " AS " ~ normalize_name(key)) -%}
    {%- endfor -%}

    SELECT
        _dbt_source_relation AS _table_name,        
        _airbyte_emited_at AS _emited_at,
        NOW() as _normalized_at,
        {{ column_list|join(', \n') }}
    FROM {{ source_table }}
{%- endif -%}
{%- endmacro -%}