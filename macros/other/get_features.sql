{% macro get_features(features_list) %}

{#- это макрос, который получает список источников проекта из переменной и передаёт их в metadata -#}

{% set features = features_list %} {# передаём через Airflow #}

{# set features = ['ym', 'yd', 'appmetrica'] #} {# без Airflow напрямую записываем значения #}

{{ features }}

{% endmacro %}

