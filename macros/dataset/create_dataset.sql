{%- macro create_dataset(
  params = none,
  override_target_metadata=none,
  override_target_model_name=none
  ) -%}

{%- set model_name_parts = (override_target_model_name or this.name).split('_') -%}
{%- set dataset_name = model_name_parts[1:] -%}
{%- set dataset_name = '_'.join(dataset_name) -%}
{%- set metadata = fromyaml(etlcraft.metadata()) -%}
{%- set dataset_info = metadata['datasets'][dataset_name] -%}

{%- set source_field = "splitByChar('_', __table_name)[4]" -%}
{%- set preset_field = "splitByChar('_', __table_name)[4]" -%}
{%- set accounts_field = "splitByChar('_', __table_name)[4]" -%}






SELECT * 
{% if 'funnel' in dataset_info %}
  FROM  {{ ref('attr_' ~ dataset_info.funnel  ~ '_final_table') }}
{% else %}
 FROM {{ ref('full_' ~ dataset_info.pipelines) }}
{% endif %}

WHERE 
{{source_field}} in {% if 'sources' in dataset_info %} {{dataset_info.sources }}  {% else %} {{source_field}} {% endif %}
and 
{{preset_field}} in {% if 'preset' in dataset_info %} '{{dataset_info.preset }}' {% else %} {{preset_field}} {% endif %}
and 
{{accounts_field}} in  {% if 'accounts' in dataset_info %} {{dataset_info.accounts }}  {% else %} {{accounts_field}} {% endif %}
 





{% endmacro %}