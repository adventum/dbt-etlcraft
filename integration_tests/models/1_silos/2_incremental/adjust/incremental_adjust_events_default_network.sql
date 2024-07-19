-- depends_on: {{ ref('normalize_adjust_events_default_network') }}
{{ etlcraft.incremental() }}