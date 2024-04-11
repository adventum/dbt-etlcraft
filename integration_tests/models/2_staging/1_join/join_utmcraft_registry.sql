-- depends_on: {{ ref('incremental_utmcraft_registry_default_utmresult') }}
{{ etlcraft.join(disable_incremental=true) }}