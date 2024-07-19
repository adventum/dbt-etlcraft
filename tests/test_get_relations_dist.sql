{% set source_query %}
    SELECT 
    '' as database,
    'incremental_testsourcetypename_testtemplatename' as table,
    'test_col1'as name
    UNION all
    SELECT 
    '' as database,
    'incremental_testsourcetypename_testtemplatename' as table,
    'test_col2'as name
    UNION all
    SELECT 
    '' as database,
    'incremental_testsourcetypename_testtemplatename' as table,
    'test_col3'as name
    UNION all
    SELECT 
    '' as database,
    'normalize_testsourcetypename_testtemplatename' as table,
    'test_col1'as name
    UNION all
    SELECT 
    '' as database,
    'normalize_testsourcetypename_testtemplatename' as table,
    'test_col2'as name
    UNION all
    SELECT 
    '' as database,
    'normalize_testsourcetypename_testtemplatename' as table,
    'test_col3'as name
{% endset %}

{% set relations_dict = etlcraft.get_relations_dict('incremental','testsourcetypename','testtemplatename',source_query) %}

{% if "incremental_testsourcetypename_testtemplatename" not in relations_dict %} 
SELECT 'Unknown key'
{% elif "normalize_testsourcetypename_testtemplatename"  in relations_dict %} 
SELECT 'Unknown key'
{% elif relations_dict is not mapping %} 
SELECT 'Unknown relations_dict type'
{% else %}
SELECT 'Unknown key' WHERE 1!=1
{% endif %}