-- depends_on: {{ ref('attr_mysecondfunnel_find_new_period') }}
{{ etlcraft.attr(features_list=['ym','yd','appmetrica']) }}

