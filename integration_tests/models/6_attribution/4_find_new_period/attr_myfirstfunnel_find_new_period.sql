-- depends_on: {{ ref('attr_myfirstfunnel_add_row_number') }}
{{ etlcraft.attr(features_list=['ym','yd','appmetrica']) }}