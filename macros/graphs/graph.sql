{%- macro graph(
  params = none,
  override_target_metadata=none,
  features_list=none,
  override_target_model_name=none,
  limit0=none
  ) -%}


{%- set stage_name = (override_target_model_name or this.name) -%}


{{ etlcraft[stage_name](params,override_target_metadata,features_list,stage_name)}}


{% endmacro %}