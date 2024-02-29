{%- macro combine_events_default(
    pipeline_name,
    template_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

SELECT  * FROM {{ ref('join_appmetrica_events_default_events') }}
UNION ALL
SELECT  * FROM {{ ref('join_appmetrica_events_default_screen_view') }}


{% endmacro %}