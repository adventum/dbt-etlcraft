-- depends_on: {{ ref('link_registry_appprofilematching') }}
-- depends_on: {{ ref('link_registry_utmhashregistry') }}
-- depends_on: {{ ref('link_periodstat') }}
{{ etlcraft.full(features_list=['ym','yd','appmetrica']) }}