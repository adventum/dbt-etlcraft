-- depends_on: {{ ref('incremental_yd_datestat_default_custom_report') }}
{{ etlcraft.join() }}

