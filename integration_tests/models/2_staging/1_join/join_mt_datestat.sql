-- depends_on: {{ ref('incremental_mt_datestat_default_banners_statistics') }}
-- depends_on: {{ ref('incremental_mt_registry_default_banners') }}
-- depends_on: {{ ref('incremental_mt_registry_default_campaigns') }}
{{ datacraft.join() }}