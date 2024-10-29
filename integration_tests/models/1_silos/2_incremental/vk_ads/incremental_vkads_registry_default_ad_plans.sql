-- depends_on: {{ ref('normalize_vkads_registry_default_ad_plans') }}
{{ datacraft.incremental(disable_incremental=true) }}