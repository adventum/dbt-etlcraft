-- depends_on: {{ ref('normalize_ym_events_default_yandex_metrika_stream') }}
{{ etlcraft.incremental() }}