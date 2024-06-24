{% macro get_features(features_list) %}

{#- это макрос, который получает список источников проекта из переменной и передаёт их в metadata -#}

{% set features = features_list %} 

{{ features }}

{% endmacro %}