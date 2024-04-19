-- depends_on: {{ ref('incremental_appmetrica_registry_default_profiles') }}
{{ etlcraft.join(disable_incremental=True) }}