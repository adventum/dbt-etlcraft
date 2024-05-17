-- depends_on: {{ ref('normalize_utmcraft_registry_default_utmresult') }}
{{ etlcraft.incremental(disable_incremental=true) }}