-- depends_on: {{ ref('normalize_mt_registry_default_campaigns') }}
{{ etlcraft.incremental(disable_incremental=true) }}