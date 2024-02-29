-- depends_on: {{ ref('join_appmetrica_events_default_events') }}
-- depends_on: {{ ref('join_appmetrica_events_default_screen_view') }}
{{ etlcraft.combine() }}