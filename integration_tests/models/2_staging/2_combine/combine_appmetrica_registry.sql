-- depends_on: {{ ref('join_appmetrica_registry_app_profile_matching') }}
{{ etlcraft.combine() }}