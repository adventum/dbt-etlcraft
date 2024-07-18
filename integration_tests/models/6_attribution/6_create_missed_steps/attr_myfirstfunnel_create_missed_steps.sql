-- depends_on: {{ ref('attr_myfirstfunnel_calculate_period_number') }}
{{ etlcraft.attr(features_list=['ym','yd','appmetrica']) }}

