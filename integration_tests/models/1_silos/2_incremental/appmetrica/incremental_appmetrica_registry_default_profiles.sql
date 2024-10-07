-- depends_on: {{ ref('normalize_appmetrica_registry_default_profiles') }}
{{ datacraft.incremental(disable_incremental=true) }}