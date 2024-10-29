-- depends_on: {{ ref('normalize_vkads_datestat_default_ad_plans_statistics') }}
{{ datacraft.incremental() }}