-- depends_on: {{ ref('graph_unique') }}
-- depends_on: {{ ref('graph_tuples') }}
{{ etlcraft.graph() }}