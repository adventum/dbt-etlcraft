-- depends_on: {{ ref('attr_mysecondfunnel_prepare_with_qid') }}
{{ etlcraft.attr(features_list=['ym','yd','appmetrica']) }}

