-- depends_on: {{ ref('join_mt_datestat_default') }}
-- depends_on: {{ ref('join_vkads_datestat_default') }}
-- depends_on: {{ ref('join_yd_datestat_default') }}
{{ etlcraft.combine() }}