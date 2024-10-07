-- depends_on: {{ ref('normalize_adjust_registry_default_events') }}
{{ datacraft.incremental(disable_incremental=true) }}