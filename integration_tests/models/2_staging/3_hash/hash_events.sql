-- depends_on: {{ ref('combine_events') }}
{{ etlcraft.hash(features_list=['ym','yd','appmetrica']) }}