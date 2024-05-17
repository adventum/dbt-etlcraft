-- depends_on: {{ ref('normalize_vkads_periodstat_default_ad_plans') }}
{{ etlcraft.incremental(disable_incremental=true) }}