-- depends_on: {{ ref('link_events') }}
{{ etlcraft.graph(features_list=['ym','yd','appmetrica']) }}