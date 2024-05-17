-- depends_on: {{ ref('normalize_mt_registry_default_banners') }}
{{ etlcraft.incremental(disable_incremental=true) }}