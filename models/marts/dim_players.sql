select
    player_id as player_key,
    *
from {{ ref('stg_nflverse__players') }}
