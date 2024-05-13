SELECT * FROM (
{{ etlcraft.normalize(override_target_model_name='normalize_appmetrica_events_default_events',fields=['__clientName','__productName','app_version_name','appmetrica_device_id','city','event_receive_datetime','event_json','event_name','google_aid','installation_id','ios_ifa','os_name','profile_id','session_id']) }}
)
WHERE event_name != 'screen_view'
