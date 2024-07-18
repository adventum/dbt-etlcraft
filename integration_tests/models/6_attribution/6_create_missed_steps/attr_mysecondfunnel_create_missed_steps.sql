-- depends_on: {{ ref('attr_mysecondfunnel_calculate_period_number') }}
{{ etlcraft.attr(features_list=['ym','yd','appmetrica']) }}

