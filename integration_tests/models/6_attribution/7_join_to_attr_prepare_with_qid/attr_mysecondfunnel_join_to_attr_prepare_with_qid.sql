-- depends_on: {{ ref('attr_mysecondfunnel_prepare_with_qid') }}
-- depends_on: {{ ref('attr_mysecondfunnel_create_missed_steps') }}
{{ etlcraft.attr(features_list=['ym','yd','appmetrica']) }}