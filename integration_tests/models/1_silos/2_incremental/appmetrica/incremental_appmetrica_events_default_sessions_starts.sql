-- depends_on: {{ ref('normalize_appmetrica_events_default_sessions_starts') }}
{{ datacraft.incremental() }}