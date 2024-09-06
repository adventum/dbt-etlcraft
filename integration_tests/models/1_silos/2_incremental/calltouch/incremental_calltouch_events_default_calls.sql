-- depends_on: {{ ref('normalize_calltouch_events_default_calls') }}
{{ etlcraft.incremental() }}