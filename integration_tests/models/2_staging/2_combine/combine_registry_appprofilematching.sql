-- depends_on: {{ ref('join_appmetrica_registry_appprofilematching') }}
{{ etlcraft.combine() }}