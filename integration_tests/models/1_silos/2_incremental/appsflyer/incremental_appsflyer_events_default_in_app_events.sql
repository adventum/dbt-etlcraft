-- depends_on: {{ ref('normalize_appsflyer_events_default_in_app_events') }}
{{ datacraft.incremental() }}