-- depends_on: {{ ref('incremental_utmcraft_registry_default_utmresult') }}
{{ datacraft.join(disable_incremental=True) }}