{% macro get_features(features_list) %}

{#- это макрос, который получает список источников проекта из переменной и передаёт их в metadata -#}

{#- передаём через Airflow: features_list -#}
{#- без Airflow напрямую записываем значения, например: ['ym', 'yd', 'appmetrica'] -#}
{% set features = ['ym', 'yd', 'appmetrica'] %} 

{{ features }}

{% endmacro %}

