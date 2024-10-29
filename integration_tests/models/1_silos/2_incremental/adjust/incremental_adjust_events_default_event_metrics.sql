-- depends_on: {{ ref('normalize_adjust_events_default_event_metrics') }}
{{ datacraft.incremental() }}