-- depends_on: {{ ref('normalize_sheets_periodstat_default_leads') }}
{{ etlcraft.incremental() }}