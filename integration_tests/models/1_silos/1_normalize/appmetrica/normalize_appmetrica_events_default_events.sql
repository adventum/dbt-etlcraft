SELECT * FROM (
{{ etlcraft.normalize(fields=['__clientName','__productName','app_version_name','appmetrica_device_id','city','event_datetime','event_json','event_name','google_aid','installation_id','ios_ifa','os_name','profile_id','session_id']) }}
)
WHERE event_name != 'screen_view'
