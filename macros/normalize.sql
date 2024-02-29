{%- macro normalize(
    included_fields=[], 
    excluded_fields=[], 
    incremental_datetime_field=none, 
    disable_incremental_datetime_field=none,
    defaults_dict=etlcraft.etlcraft_defaults(), 
    schema_pattern=this.schema, 
    source_table=none, 
    override_target_model_name=none,
    debug_column_names=False) -%}

{#- выполнять на втором этапе после выведения зависимостей (первый этап - parse, здесь делается manifest, на втором этапе уже поймёт ref - возьмет его из манифеста. Надо завернуть в execute, иначе будет пусто -#}
{%- if execute -%}

    {#- задаём части имени - либо из параметра, либо из имени файла - разбивая на части по знаку _ -#}
    {%- set model_name_parts = (override_target_model_name or this.name).split('_') -%}

    {#- если имя модели не соответсвует шаблону - выдаём ошибку -#}
    {%- if model_name_parts|length < 5 or model_name_parts[0] != 'normalize' -%}
        {{ exceptions.raise_compiler_error('Model name "' ~ this.name ~ '" does not follow the expected pattern: "normalize_{sourcetype_name}_{pipeline_name}_{template_name}_{stream_name}"') }}
    {%- endif -%}

    {#- задаём переменные - источник, пайплайн, шаблон, поток, и паттерн собранный из них -#}
    {%- set sourcetype_name = model_name_parts[1] -%}
    {%- set pipeline_name = model_name_parts[2] -%}
    {%- set template_name = model_name_parts[3] -%}
    {%- set stream_name_parts = model_name_parts[4:] -%}
    {%- set stream_name = '_'.join(stream_name_parts) -%}
    {%- set table_pattern = '_airbyte_raw_' ~ sourcetype_name ~ '_' ~ pipeline_name ~ '_' ~ template_name ~ '_[^_]+_' ~ stream_name ~ '$' -%}

    {#- если параметр source_table при вызове макроса не задан -#}
    {%- if source_table is none -%}

        {#- задаём relations при помощи собственного макроса - он находится в clickhouse-adapters - найти все таблицы, которые подходят под единый шаблон, например, все mt для какого-либо проекта -#}
        {%- set relations = etlcraft.get_relations_by_re(schema_pattern=target.schema, 
                                                              table_pattern=table_pattern) -%}   
        {#- если что-то не так - выдаём ошибку -#}                                                                  
        {%- if not relations -%}
            {{ exceptions.raise_compiler_error('No relations were found matching the pattern "' ~ table_pattern ~ '". Please ensure that your source data follows the expected structure.') }}
        {%- endif -%}

        {#- собираем одинаковые таблицы, которые будут проходить по этому макросу  - здесь union all найденных таблиц -#}
        {%- set source_table = '(' ~ dbt_utils.union_relations(relations) ~ ')' -%}    
    {%- endif -%}

    {#- пытаемся запустить запрос - первый сценарий -#}
    {% if run_query('SELECT ' ~ etlcraft.json_list_keys('_airbyte_data') ~ ' FROM ' ~ source_table ~ '  LIMIT 1').columns[0]|length > 0 %}
        {#- если получается, берём самый длинный список колонок -#}
        {%- set json_keys = fromjson(run_query('SELECT ' ~ etlcraft.json_list_keys('_airbyte_data') ~ ' FROM ' ~ source_table ~ ' ORDER BY JSONLength(JSONExtractRaw(_airbyte_data)) desc LIMIT 1').columns[0].values()[0]) -%}
    {#- если не получается -#}
    {%- else -%}    
        {#- выполняем этот запрос - это второй сценарий - если уже есть инкрементальная таблица, а новых сырых данных нет -#}
        {%- set query -%}
        SELECT 
            column_name
        FROM information_schema.columns 
        WHERE 
            table_catalog = '{{this.schema}}'
            and table_name = 'incremental_{{sourcetype_name}}_{{pipeline_name}}_{{template_name}}_{{stream_name}}'
            and not match(column_name,'^__*')
        ORDER BY ordinal_position
        {%- endset -%}
        {#- и из этого запроса берём колонки -#}
        {%- set json_keys = run_query(query).columns[0].values() -%}
    {%- endif -%} 

    {#- если при вызове макроса параметры не заданы -#}
    {%- if incremental_datetime_field is none and disable_incremental_datetime_field is none -%}
        {#-  задаём переменную incremental_datetime_field -#}
        {%- set incremental_datetime_field = etlcraft.find_incremental_datetime_field(json_keys, override_target_model_name or this.name, defaults_dict=defaults_dict) or '' -%}
    {%- endif -%}
    {#- задаём прочие переменные, чтобы определить конечный список полей -#}
    {%- set default_included_fields = [] -%}
    {%- set default_excluded_fields = [] -%}
    {%- set default_included_fields = etlcraft.get_from_default_dict(defaults_dict, ['sourcetypes', sourcetype_name, 'included_fields'], []) -%}
    {%- set default_excluded_fields = etlcraft.get_from_default_dict(defaults_dict, ['sourcetypes', sourcetype_name, 'excluded_fields'], []) -%}        
    {%- set default_included_fields = default_included_fields + etlcraft.get_from_default_dict(defaults_dict, ['sourcetypes', sourcetype_name, 'streams', stream_name, 'included_fields'], []) -%}
    {%- set default_excluded_fields = default_excluded_fields + etlcraft.get_from_default_dict(defaults_dict, ['sourcetypes', sourcetype_name, 'streams', stream_name, 'excluded_fields'], []) -%}    
    {%- set column_set = set(json_keys).union(set(included_fields)).union(set(default_included_fields)).difference(set(excluded_fields)).difference(set(default_excluded_fields)) -%}
    {%- set column_list = [] -%}

    {#- для каждого столбца в полученном наборе -#}
    {%- for key in column_set -%}        
        {#- если оно не является инкрементальным полем с датой 
        {%- if  key != incremental_datetime_field -%} -#}
            {#- устанавливаем псевдоним - делаем транслитерацию на англ -#}
            {%- set alias = etlcraft.normalize_name(key) -%}
            {%- set column_value = etlcraft.json_extract_string('_airbyte_data', key) if not debug_column_names else "'" ~ alias ~ "'" -%}
            {#- в итоговый список добавялем обработанное значение столбца -#}
            {%- do column_list.append(column_value ~ " AS " ~ alias) -%}
         {#-{%- endif -%} -#}
    {%- endfor -%}

    {#- сортируем итоговый список полей - по алфавиту -#}
    {%- set column_list = column_list | sort -%}
    {#- преобразование для инкрементального поля с датой -#}
    {%- if incremental_datetime_field -%}
        {%- set column_value = etlcraft.json_extract_string('_airbyte_data', incremental_datetime_field) if not debug_column_names else "'__date'" -%}        
        {%- set column_list = [column_value ~ " AS __date"] + column_list -%}
    {%- endif -%}
    {#- условие для пустого итогового списка -#}
    {%- if column_list | length == 0 -%}
        {{ exceptions.raise_compiler_error('Normalize returned empty column list') }}
    {%- endif -%}

    {#- это самое важное - что мы видим в модели - SELECT итогового списка полей + технические поля из Airbyte -#}
    SELECT
        {{ column_list | join(', \n') }},
        toLowCardinality(_dbt_source_relation) AS __table_name,  
        {#- варианты парсинга дат:  parseDateTimeBestEffort,toDateTime32,toDateTimeOrDefault,toDate(splitByWhitespace(dt)[1]) -#}
        toDateTime32(substring(_airbyte_emitted_at, 1, 19)) AS __emitted_at, 
        NOW() as __normalized_at
    FROM {{ source_table }}
{%- endif -%}
{%- endmacro -%}

