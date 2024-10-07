-- depends_on: {{ ref('normalize_utmcraft_registry_default_utmresult') }}
{{ datacraft.incremental(disable_incremental=true) }}