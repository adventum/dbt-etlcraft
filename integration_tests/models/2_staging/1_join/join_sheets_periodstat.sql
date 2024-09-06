-- depends_on: {{ ref('incremental_sheets_periodstat_default_planCosts') }}
{{ etlcraft.join() }}