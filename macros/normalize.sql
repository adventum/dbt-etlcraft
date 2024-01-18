{%- macro normalize(included_fields=[], excluded_fields=[], incremental_datetime_field=none,
    defaults_dict=etlcraft.etlcraft_defaults(), schema_pattern=this.schema, source_table=none, override_target_model_name=none,
    debug_column_names=False) -%}
{%- if execute -%}
    {%- set model_name_parts = (override_target_model_name or this.name).split('_') -%}
    {%- if model_name_parts|length < 4 or model_name_parts[0] != 'normalize' -%}
        {{ exceptions.raise_compiler_error('Model name "' ~ this.name ~ '" does not follow the expected pattern: "normalize_{sourcetype}_{templatename}_{streamname}"') }}
    {%- endif -%}
    {%- set source_type = model_name_parts[1] -%}
    {%- set template_name = model_name_parts[2] -%}
    {%- set stream_name_parts = model_name_parts[3:] -%}
    {%- set stream_name = '_'.join(stream_name_parts) -%}
    {%- set table_pattern = '_airbyte_raw_' ~ source_type ~ '_' ~ template_name ~ '_[^_]+_' ~ stream_name -%}
    {%- if source_table is none -%}
        {%- set relations = etlcraft.get_relations_by_re(schema_pattern=target.schema, 
                                                              table_pattern=table_pattern) -%}                
        {%- if not relations -%}
            {{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern ~ '". Please ensure that your source data follows the expected structure.') }}
        {%- endif -%}
        {%- set source_table = '(' ~ dbt_utils.union_relations(relations) ~ ')' -%}    
    {%- endif -%}
    {% if run_query('SELECT ' ~ etlcraft.json_list_keys('_airbyte_data') ~ ' FROM ' ~ source_table ~ '  LIMIT 1').columns[0]|length > 0 %}
        {%- set json_keys = fromjson(run_query('SELECT ' ~ etlcraft.json_list_keys('_airbyte_data') ~ ' FROM ' ~ source_table ~ ' ORDER BY JSONLength(JSONExtractRaw(_airbyte_data)) desc LIMIT 1').columns[0].values()[0]) -%}
    {% else %}    
        {% set query %}
        SELECT 
            column_name
        FROM information_schema.columns 
        WHERE 
            table_catalog = '{{this.schema}}'
            and table_name = 'incremental_{{source_type}}_{{template_name}}_{{stream_name}}'
            and not match(column_name,'^__*')
        ORDER BY ordinal_position
        {% endset %}
        {%- set json_keys = run_query(query).columns[0].values() -%}
    {%- endif -%} 
    {% if incremental_datetime_field is none %}
        {% set incremental_datetime_field = etlcraft.find_incremental_datetime_field(json_keys, override_target_model_name or this.name, defaults_dict=defaults_dict) or '' %}
    {% endif %}
    {%- set default_included_fields = [] -%}
    {%- set default_excluded_fields = [] -%}
    {%- set default_included_fields = etlcraft.get_from_default_dict(defaults_dict, ['sourcetypes', source_type, 'included_fields'], []) -%}
    {%- set default_excluded_fields = etlcraft.get_from_default_dict(defaults_dict, ['sourcetypes', source_type, 'excluded_fields'], []) -%}        
    {%- set default_included_fields = default_included_fields + etlcraft.get_from_default_dict(defaults_dict, ['sourcetypes', source_type, 'streams', stream_name, 'included_fields'], []) -%}
    {%- set default_excluded_fields = default_excluded_fields + etlcraft.get_from_default_dict(defaults_dict, ['sourcetypes', source_type, 'streams', stream_name, 'excluded_fields'], []) -%}    
    {%- set column_set = set(json_keys).union(set(included_fields)).union(set(default_included_fields)).difference(set(excluded_fields)).difference(set(default_excluded_fields)) -%}
    {%- set column_list = [] -%}
    {%- for key in column_set -%}        
        {%- if  key != incremental_datetime_field -%}
            {%- set alias = etlcraft.normalize_name(key) -%}
            {%- set column_value = etlcraft.json_extract_string('_airbyte_data', key) if not debug_column_names else "'" ~ alias ~ "'" -%}
            {%- do column_list.append(column_value ~ " AS " ~ alias) -%}
        {%- endif -%}
    {%- endfor -%}
    {%- set column_list = column_list | sort -%}
    {%- if incremental_datetime_field -%}
        {%- set column_value = etlcraft.json_extract_string('_airbyte_data', incremental_datetime_field) if not debug_column_names else "'__datetime'" -%}        
        {%- set column_list = [column_value ~ " AS __datetime"] + column_list -%}
    {%- endif -%}
    {%- if column_list | length == 0 -%}
        {{ exceptions.raise_compiler_error('Normalize returned empty column list') }}
    {%- endif -%}

    SELECT
        {{ column_list | join(', \n') }},
        toLowCardinality(_dbt_source_relation) AS __table_name,        
        toDateTime32(_airbyte_emitted_at) AS __emitted_at,
        NOW() as __normalized_at
    FROM {{ source_table }}
{%- endif -%}
{%- endmacro -%}