-- depends_on: {{ ref('graph_qid') }}
-- depends_on: {{ ref('link_appmetrica_registry') }}
{{ etlcraft.full() }}

