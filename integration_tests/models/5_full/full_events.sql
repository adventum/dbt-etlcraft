-- depends_on: {{ ref('graph_qid') }}
-- depends_on: {{ ref('link_appmetrica_registry') }}
-- depends_on: {{ ref('link_utmcraft_registry') }}
{{ etlcraft.full() }} 

