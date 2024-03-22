-- depends_on: {{ ref('incremental_ym_events_default_yandex_metrika_stream') }}
{{ etlcraft.join() }}