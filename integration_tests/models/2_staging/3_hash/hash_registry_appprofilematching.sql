-- depends_on: {{ ref('combine_registry_appprofilematching') }}
{{ etlcraft.hash(features_list=['ym','yd','appmetrica']) }}