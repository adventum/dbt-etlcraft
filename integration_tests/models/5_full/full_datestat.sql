-- depends_on: {{ ref('link_datestat') }}
-- depends_on: {{ ref('link_registry_appprofilematching') }}
-- depends_on: {{ ref('link_registry_utmhashregistry') }}
{{ etlcraft.full(features_list=['ym','yd','appmetrica']) }}

