{%- macro full(
  params = none,
  disable_incremental=none,
  override_target_model_name=none,
  date_from = none,
  date_to = none) 
-%}


                                                               
{%- set link_registry_tables = etlcraft.custom_union_relations(relations=[ref('graph_qid'), ref('link_appmetrica_registry')]) -%}
 
SELECT * FROM {{ link_registry_tables }}



{% endmacro %}