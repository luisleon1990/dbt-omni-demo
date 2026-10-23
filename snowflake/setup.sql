-- One-time Snowflake setup for the dbt project. Run as ACCOUNTADMIN (or a role with the same grants).
-- Uses the existing DBT_DEMO_ROLE and the existing user LUISANDRE@OMNI.CO (demo instance).
-- Nothing here touches PROD_SPORTS.RAW except granting read access.

use role ACCOUNTADMIN;

-- 1. Database dbt builds into, with the prod schemas pre-created
create database if not exists LUIS_NFL_DEMO;
create schema if not exists LUIS_NFL_DEMO.STAGING;
create schema if not exists LUIS_NFL_DEMO.MARTS;

-- 2. Make sure the demo user can use the role (no-op if already granted)
grant role DBT_DEMO_ROLE to user "LUISANDRE@OMNI.CO";

-- 3. dbt reads the raw data and owns what it builds
grant usage on warehouse COMPUTE_WH to role DBT_DEMO_ROLE;
grant usage on database PROD_SPORTS to role DBT_DEMO_ROLE;
grant usage on schema PROD_SPORTS.RAW to role DBT_DEMO_ROLE;
grant select on all tables in schema PROD_SPORTS.RAW to role DBT_DEMO_ROLE;
grant select on future tables in schema PROD_SPORTS.RAW to role DBT_DEMO_ROLE;

grant all on database LUIS_NFL_DEMO to role DBT_DEMO_ROLE;
grant all on all schemas in database LUIS_NFL_DEMO to role DBT_DEMO_ROLE;
grant all on future schemas in database LUIS_NFL_DEMO to role DBT_DEMO_ROLE;
-- dev builds create schemas such as DBT_<name>_STAGING in the same database, which the grants above allow.

-- 4. Let Omni's role read what dbt builds (ANALYST is the role Omni's connection signs in with)
grant usage on database LUIS_NFL_DEMO to role ANALYST;
grant usage on schema LUIS_NFL_DEMO.STAGING to role ANALYST;
grant usage on schema LUIS_NFL_DEMO.MARTS to role ANALYST;
grant select on all tables in schema LUIS_NFL_DEMO.MARTS to role ANALYST;
grant select on future tables in schema LUIS_NFL_DEMO.MARTS to role ANALYST;
grant select on all views in schema LUIS_NFL_DEMO.STAGING to role ANALYST;
grant select on future views in schema LUIS_NFL_DEMO.STAGING to role ANALYST;
