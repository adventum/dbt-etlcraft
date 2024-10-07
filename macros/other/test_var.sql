{% macro test_var() %}
{% set source_query %}
    SELECT 
    'test' as database,
    'incremental_testsourcetypename_testtemplatename' as table,
    '__datetime' as name,
    '2023-12-01' as __datetime
    UNION all
    SELECT 
    'test' as database,
    'incremental_testsourcetypename_testtemplatename' as table,
    'test_col2'as name,
    '2023-12-02' as __datetime
    UNION all
    SELECT 
    'test' as database,
    'incremental_testsourcetypename_testtemplatename' as table,
    '__datetime' as name,
    '2023-12-03' as __datetime
    UNION all
    SELECT 
    '' as database,
    'normalize_testsourcetypename_testtemplatename' as table,
    '__datetime' as name,
    '2023-12-01' as __datetime
    UNION all
    SELECT 
    '' as database,
    'normalize_testsourcetypename_testtemplatename' as table,
    'test_col2' as name,
    '2023-12-02' as __datetime
    UNION all
    SELECT 
    '' as database,
    'normalize_testsourcetypename_testtemplatename' as table,
    'test_col3' as name,
    '2023-12-03' as __datetime
{% endset %}

{% set min_max_date = datacraft.get_min_max_date('incremental','testsourcetypename','testtemplatename',source_query) %}
{% set date_from = min_max_date.get('date_from')[0] ~'' %}
{% set date_to = min_max_date.get('date_to')[0] ~''  %}

{%- set date_from_parts = date_from.split('-') -%}
{%- set date_to_parts = date_to.split('-') -%}

{%- set date_from_int = (date_from_parts[0]~date_from_parts[1]~date_from_parts[2])| int -%}
{%- set date_to_int = (date_to_parts[0]~date_to_parts[1]~date_to_parts[2])| int -%}



{{date_from_int>date_to_int}}


{% endmacro %}