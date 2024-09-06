-- depends_on: {{ ref('join_sheets_periodstat') }}
{{ etlcraft.combine() }}