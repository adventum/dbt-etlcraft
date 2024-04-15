{% macro get_column_count_in_subquery(subquery) %}
    (select JSONLength(
        replaceRegexpAll(
            replaceRegexpOne(
                replaceRegexpOne(
                    replaceRegexpAll(
                        toString(tuple(*)), 
                        '"', ''), 
                    '^\(', '['), 
                '\)$', ']'),
            '''', 
        '"'))
     from ({{ subquery }}) limit 1)
{% endmacro %}