



SELECT
'Error: Incorrect datetime field identified without dict by name'
WHERE 'mydatetime' != 'mydatetime'



UNION ALL SELECT
'Error: Incorrect datetime field identified with dict for source type'
WHERE 'updated_at' != 'updated_at'



UNION ALL SELECT
'Error: Incorrect datetime field identified with dict for stream'
WHERE 'created_at' != 'created_at'



UNION ALL SELECT
'Error: Incorrect datetime field identified when there is no incremental field'
WHERE 'True' != 'True'