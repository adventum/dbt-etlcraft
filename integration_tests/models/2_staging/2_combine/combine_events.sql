-- depends_on: {{ ref('join_appmetrica_events_deeplinks') }}
-- depends_on: {{ ref('join_appmetrica_events_events') }}
-- depends_on: {{ ref('join_appmetrica_events_install') }}
-- depends_on: {{ ref('join_appmetrica_events_screen_view') }}
-- depends_on: {{ ref('join_appmetrica_events_sessions_starts') }}
-- depends_on: {{ ref('join_appmetrica_registry_profiles') }}
-- depends_on: {{ ref('join_ym_events') }}
{{ etlcraft.combine() }}