{% macro make_date_zero(date) -%}
toDate ( 
            replaceRegexpOne (replaceRegexpOne ({{date}}, '\\s+(\\d):', ' 0\\1:'),
            '(\\d{2})\\.(\\d{2})\\.(\\d{4})', '\\3-\\2-\\1'), 'Europe/Moscow')
{%- endmacro %}