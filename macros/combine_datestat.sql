{%- macro combine_datestat_default(
    pipeline_name,
    template_name,
    relations_dict,
    date_from,
    date_to,
    params
    ) -%}

{%- macro combine_datestat(
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
        ref('join_mt_datestat'), ref('join_vkads_datestat'),
        ref('join_yd_datestat'),
      ],
      exclude=['_DBT_SOURCE_RELATION']
  ) }}


{% endmacro %}