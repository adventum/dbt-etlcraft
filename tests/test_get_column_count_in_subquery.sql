{% set subquery = "SELECT 1, 'string', '', 'string with \" and with \'''" %}
{% set result = get_column_count_in_subquery(subquery) %}

SELECT 1 AS x
where {{ result}}=3