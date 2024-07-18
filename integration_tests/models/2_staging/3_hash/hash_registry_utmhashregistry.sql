-- depends_on: {{ ref('combine_registry_utmhashregistry') }}
{{ etlcraft.hash(features_list=['ym','yd','appmetrica']) }}