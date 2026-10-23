with source as (

    select * from {{ source('bdb', 'tracking_output') }}

),

renamed as (

    select
        game_id,
        play_id,
        nfl_id,
        frame_id,
        x,
        y
    from source

)

select * from renamed
