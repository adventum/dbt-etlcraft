-- depends_on: {{ ref('join_appmetrica_registry') }}
{{ etlcraft.combine() }}