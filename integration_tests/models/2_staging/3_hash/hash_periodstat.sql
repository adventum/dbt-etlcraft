-- depends_on: {{ ref('combine_periodstat') }}
{{ etlcraft.hash(features_list=['ym','yd','appmetrica']) }}