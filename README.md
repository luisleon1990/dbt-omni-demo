# nfl_analytics

dbt project over `PROD_SPORTS.RAW` (Big Data Bowl 2026 tracking and nflverse data). Builds into `LUIS_NFL_DEMO`.

- `models/staging` – one model per raw table (rosters for 2023-2025 are unioned). Views in `STAGING`.
- `models/marts` – `dim_teams`, `dim_players`, `dim_games`, `fct_player_week_stats`, `fct_team_week_stats`, `fct_plays`, `fct_tracking` (incremental). Tables in `MARTS`.
- `models/marts/_semantic_models.yml`, `_metrics.yml` – MetricFlow semantic models (plays, player_week_stats, games) and 14 metrics. `metricflow_time_spine` supports time queries.
- `snowflake/setup.sql` – database, roles and grants. Run once before the first build.
- `macros/generate_schema_name.sql` – in an environment whose target name is `prod`, schemas are exactly `STAGING` and `MARTS`; elsewhere they are prefixed with the developer's schema.

## dbt platform settings
- Production environment: target name `prod`, database `LUIS_NFL_DEMO`, role `DBT_ROLE`, warehouse `COMPUTE_WH`.
- Deploy job: `dbt build`.
- The project sits at the repo root, so no subdirectory is needed.

## Omni dbt environment
Match dbt platform exactly: Default Database `LUIS_NFL_DEMO`, Target Name `prod`, Target Role `DBT_ROLE`. Default Schema is `MARTS`.
