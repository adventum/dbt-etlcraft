-- depends_on: {{ ref('join_appmetrica_events') }}
-- depends_on: {{ ref('join_ym_events') }}
{{ datacraft.combine() }}