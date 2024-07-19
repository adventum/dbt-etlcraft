-- depends_on: {{ ref('combine_datestat') }}
{{ etlcraft.hash(features_list=['ym','yd','appmetrica']) }}