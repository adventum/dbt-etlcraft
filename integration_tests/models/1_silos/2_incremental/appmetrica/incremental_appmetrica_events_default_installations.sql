-- depends_on: {{ ref('normalize_appmetrica_events_default_installations') }}
{{ etlcraft.incremental() }}