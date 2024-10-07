-- depends_on: {{ ref('normalize_appmetrica_events_default_events') }}
{{ datacraft.incremental() }}