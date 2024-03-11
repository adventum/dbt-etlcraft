-- depends_on: {{ ref('join_appmetrica_events_events') }}
-- depends_on: {{ ref('join_appmetrica_events_screen_view') }}
{{ etlcraft.combine() }}