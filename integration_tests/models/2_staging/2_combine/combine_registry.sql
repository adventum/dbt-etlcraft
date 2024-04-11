-- depends_on: {{ ref('join_appmetrica_registry_app_profile_matching') }}
-- depends_on: {{ ref('join_utmcraft_registry') }}
{{ etlcraft.combine() }}