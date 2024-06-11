{%- macro attr(
  params = none,
  override_target_metadata=none,
  override_target_model_name=none
  ) -%}





{%- set model_name_parts = (override_target_model_name or this.name).split('_') -%}
{%- set funnel_name = model_name_parts[1] -%}
{%- set stage_name = model_name_parts[2:] -%}

{%- set stage_name = 'attr_' ~ '_'.join(stage_name) -%}


{{ etlcraft[stage_name](params,override_target_metadata,funnel_name)}}


{% endmacro %}