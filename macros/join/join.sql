{%- macro join(
  params = none,
  disable_incremental=none,
  override_target_model_name=none,
  date_from = none,
  date_to = none,
  limit0=none
  ) -%}

{#- задаём части имени -#}
{%- set model_name_parts = (override_target_model_name or this.name).split('_') -%}
{%- set sourcetype_name = model_name_parts[1] -%}
{%- set pipeline_name = model_name_parts[2] -%}
{%- set link_name = model_name_parts[3] -%}

{%- if pipeline_name in ('registry', 'periodstat') -%}
{%- set disable_incremental=true -%}
{%- endif -%}

{#- устанавливаем имя макроса - туда будем перенаправлять исполнение, это название вида джойна -#}
{%- if pipeline_name != 'registry' -%}
{%- set macro_name =  'join_'~ sourcetype_name ~'_'~ pipeline_name -%}
{%- else -%}
{%- set macro_name =  'join_'~ sourcetype_name ~'_'~ pipeline_name ~ '_' ~ link_name -%}
{%- endif -%}

{#- устанавливаем имя макроса - для двух видов yandex direct - со смарт-компаниями и без них -#}
{%- if sourcetype_name == 'yd' and model_name_parts[-1] == 'smart' -%}
{%- set macro_name =  'join_'~ sourcetype_name ~'_'~ pipeline_name ~'_'~ 'smart' -%}
{%- elif sourcetype_name == 'yd' and model_name_parts[-1] != 'smart' -%}
{%- set macro_name =  'join_'~ sourcetype_name ~'_'~ pipeline_name -%}
{%- endif -%}

{#- здесь перечислены параметры, которые д.б. такими же в каждом виде макроса join -#}
{{ etlcraft[macro_name](sourcetype_name,pipeline_name,date_from,date_to,params,limit0=none)}}

{% endmacro %}


