select
    stats.player_id || '-' || stats.season || '-' || stats.week || '-' || stats.season_type as player_week_key,
    games.gameday as game_date,
    stats.*
from {{ ref('stg_nflverse__player_stats') }} as stats
left join {{ ref('dim_games') }} as games
    on stats.game_id = games.game_key
