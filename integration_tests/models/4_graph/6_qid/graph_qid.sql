-- depends_on: {{ ref('graph_lookup') }}
-- depends_on: {{ ref('graph_glue') }}
{{ etlcraft.graph() }}