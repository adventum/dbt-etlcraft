-- depends_on: {{ ref('incremental_vkads_datestat_default_ad_plans_statistics') }}
-- depends_on: {{ ref('incremental_vkads_datestat_default_ad_plans') }}
{{ etlcraft.join() }}