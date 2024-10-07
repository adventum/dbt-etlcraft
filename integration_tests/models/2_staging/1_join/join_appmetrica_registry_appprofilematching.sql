-- depends_on: {{ ref('incremental_appmetrica_registry_default_profiles') }}
{{ datacraft.join(disable_incremental=True) }}