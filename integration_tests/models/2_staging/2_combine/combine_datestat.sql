-- depends_on: {{ ref('join_mt_datestat') }}
-- depends_on: {{ ref('join_vkads_datestat') }}
-- depends_on: {{ ref('join_yd_datestat') }}
{{ etlcraft.combine() }}