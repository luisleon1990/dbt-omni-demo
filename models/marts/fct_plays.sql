with plays as (

    select * from {{ ref('stg_bdb__plays') }}

),

games as (

    select
        old_game_id,
        game_id as nflverse_game_id,
        game_type
    from {{ ref('stg_nflverse__games') }}

)

select
    plays.game_id || '-' || plays.play_id as play_key,
    plays.*,
    games.nflverse_game_id,
    games.game_type,
    plays.pass_result = 'C' as is_complete,
    plays.pass_result = 'IN' as is_interception,
    plays.pass_result = 'S' as is_sack
from plays
left join games
    on plays.game_id = games.old_game_id
