-- depends_on: {{ ref('incremental_mt_datestat_default_banners_statistics') }}
-- depends_on: {{ ref('incremental_mt_datestat_default_banners') }}
-- depends_on: {{ ref('incremental_mt_datestat_default_campaigns') }}
{{ etlcraft.join() }}