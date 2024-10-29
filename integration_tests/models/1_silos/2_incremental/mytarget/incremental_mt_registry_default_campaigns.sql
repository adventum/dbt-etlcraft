-- depends_on: {{ ref('normalize_mt_registry_default_campaigns') }}
{{ datacraft.incremental(disable_incremental=true) }}