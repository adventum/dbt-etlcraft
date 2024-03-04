{%- macro combine_events_default(
    pipeline_name,
    template_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

SELECT *
FROM 
{{ dbt_utils.union_relations(
      relations=[
        ref('join_appmetrica_events_default_events'),
        ref('join_appmetrica_events_default_screen_view'),
      ],
      exclude=['_DBT_SOURCE_RELATION']
  ) }}


{% endmacro %}