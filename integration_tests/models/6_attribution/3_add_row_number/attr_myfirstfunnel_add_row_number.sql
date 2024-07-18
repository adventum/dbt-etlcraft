-- depends_on: {{ ref('attr_myfirstfunnel_create_events') }}
{{ etlcraft.attr(features_list=['ym','yd','appmetrica']) }}

