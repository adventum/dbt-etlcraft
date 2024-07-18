-- depends_on: {{ ref('attr_myfirstfunnel_model') }}
-- depends_on: {{ ref('attr_myfirstfunnel_join_to_attr_prepare_with_qid') }}
{{ etlcraft.attr(features_list=['ym','yd','appmetrica']) }}
