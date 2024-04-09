{%- macro graph(
  params = none,
  override_target_metadata=none,
  override_target_model_name=none
  ) -%}


{%- set stage_name = (override_target_model_name or this.name) -%}


{{ etlcraft[stage_name](params,override_target_metadata,stage_name)}}


{% endmacro %}