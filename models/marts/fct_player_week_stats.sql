select
    player_id || '-' || season || '-' || week || '-' || season_type as player_week_key,
    *
from {{ ref('stg_nflverse__player_stats') }}
