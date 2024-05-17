-- depends_on: {{ ref('normalize_adjust_events_default_event_metrics') }}
{{ etlcraft.incremental() }}