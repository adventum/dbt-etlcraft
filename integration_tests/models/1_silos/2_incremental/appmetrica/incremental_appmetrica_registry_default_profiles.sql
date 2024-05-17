-- depends_on: {{ ref('normalize_appmetrica_registry_default_profiles') }}
{{ etlcraft.incremental(disable_incremental=true) }}