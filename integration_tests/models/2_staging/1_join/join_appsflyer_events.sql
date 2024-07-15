-- depends_on: {{ ref('incremental_appsflyer_events_default_in_app_events') }}
{{ etlcraft.join() }}