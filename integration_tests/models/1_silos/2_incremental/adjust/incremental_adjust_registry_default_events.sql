-- depends_on: {{ ref('normalize_adjust_registry_default_events') }}
{{ etlcraft.incremental(disable_incremental=true) }}