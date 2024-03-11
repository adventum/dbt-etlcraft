{%- macro combine_events(
    pipeline_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

SELECT *
FROM 
{{ dbt_utils.union_relations(
      relations=[
        ref('join_appmetrica_events_events'),
        ref('join_appmetrica_events_screen_view'),
      ],
      exclude=['_DBT_SOURCE_RELATION']
  ) }}


{% endmacro %}