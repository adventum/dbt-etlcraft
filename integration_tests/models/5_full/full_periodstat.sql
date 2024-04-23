-- depends_on: {{ ref('link_appmetrica_registry') }}
-- depends_on: {{ ref('link_utmcraft_registry') }}
-- depends_on: {{ ref('link_periodstat') }}
{{ etlcraft.full() }}