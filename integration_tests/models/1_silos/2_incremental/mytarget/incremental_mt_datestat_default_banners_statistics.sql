-- depends_on: {{ ref('normalize_mt_datestat_default_banners_statistics') }}
{{ etlcraft.incremental() }}