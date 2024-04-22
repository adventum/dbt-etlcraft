-- depends_on: {{ ref('link_datestat') }}
-- depends_on: {{ ref('link_appmetrica_registry') }}
-- depends_on: {{ ref('link_utmcraft_registry') }}
{{ etlcraft.full() }}

