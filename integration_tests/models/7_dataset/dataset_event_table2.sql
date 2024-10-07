-- depends_on: {{ ref('full_datestat') }}
-- depends_on: {{ ref('full_events') }}
-- depends_on: {{ ref('attr_myfirstfunnel_final_table') }}
{{ datacraft.create_dataset(
    conditions =
    [{
    'pipeline':'datestat', 
    'source': 'yd',
    'account': 'accountid',
    'preset': 'default'
    },
    {
    'pipeline': 'events', 
    'source': 'appmetrica',
    'account': 'accountid',
    'preset': 'default'
    },
    {
    'pipeline':'events', 
    'source': 'ym',
    'account': 'accountid',
    'preset': 'default'
    }
     ]
) }}
