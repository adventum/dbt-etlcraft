{%- macro join(
  params = none,
  disable_incremental=none,
  override_target_model_name=none,
  date_from = none,
  date_to = none
  ) -%}

{#- задаём части имени -#}
{%- set model_name_parts = (override_target_model_name or this.name).split('_') -%}
{%- set sourcetype_name = model_name_parts[1] -%}
{%- set pipeline_name = model_name_parts[2] -%}
{%- set link_name = model_name_parts[3] -%}

{%- if pipeline_name in ('registry') -%}
{%- set disable_incremental=true -%}
{%- endif -%}

{#- устанавливаем имя макроса - туда будем перенаправлять исполнение, это название вида джойна -#}
{%- if pipeline_name != 'registry' -%}
{%- set macro_name =  'join_'~ sourcetype_name ~'_'~ pipeline_name -%}
{%- else -%}
{%- set macro_name =  'join_'~ sourcetype_name ~'_'~ pipeline_name ~ '_' ~ link_name -%}
{%- endif -%}

{#- здесь перечислены параметры, которые д.б. такими же в каждом виде макроса join -#}
{{ etlcraft[macro_name](sourcetype_name,pipeline_name,date_from,date_to,params)}}

{% endmacro %}

{#- весь этот блок пропускаем - здесь получаем параметры date_from,date_to  -#}
{#- if not disable_incremental #}
{#- получаем список date_from:xxx[0], date_to:yyy[0] из union всех normalize таблиц -#}
  {# set min_max_date_dict = etlcraft.get_min_max_date('normalize',sourcetype_name) #}                                                             
  {# if not min_max_date_dict #} {# выдаём ошибку, если что-то не так #}
      {# {{ exceptions.raise_compiler_error('No min_max_date_dict') }} #}
  {# endif #}

  {# set date_from = min_max_date_dict.get('date_from')[0] #}
  {# if not date_from #} {# выдаём ошибку, если что-то не так #}
      {# {{ exceptions.raise_compiler_error('No date_from') }} #}
  {# endif #}

  {# set date_to = min_max_date_dict.get('date_to')[0] #}
  {# if not date_to #} {# выдаём ошибку, если что-то не так #}
      {# {{ exceptions.raise_compiler_error('No date_to') }} #}
  {# endif #}

{# endif #}  
