SELECT * FROM (
{{ etlcraft.normalize() }}
)
WHERE event_name != 'screen_view'