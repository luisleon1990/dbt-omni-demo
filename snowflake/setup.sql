-- One-time Snowflake setup for the dbt project. Run as ACCOUNTADMIN (or a role with the same grants).
-- Review the names first; nothing here touches PROD_SPORTS.RAW except granting read access.

use role ACCOUNTADMIN;

-- 1. Database dbt builds into, with the prod schemas pre-created
create database if not exists LUIS_NFL_DEMO;
create schema if not exists LUIS_NFL_DEMO.STAGING;
create schema if not exists LUIS_NFL_DEMO.MARTS;

-- 2. Role and service user for dbt platform
create role if not exists DBT_ROLE;
create user if not exists DBT_USER
    type = service
    default_role = DBT_ROLE
    default_warehouse = COMPUTE_WH;
grant role DBT_ROLE to user DBT_USER;
-- Register dbt platform's public key on the user (the key is shown in dbt platform's connection settings):
-- alter user DBT_USER set rsa_public_key = '<public key without header/footer>';

-- 3. dbt reads the raw data and owns what it builds
grant usage on warehouse COMPUTE_WH to role DBT_ROLE;
grant usage on database PROD_SPORTS to role DBT_ROLE;
grant usage on schema PROD_SPORTS.RAW to role DBT_ROLE;
grant select on all tables in schema PROD_SPORTS.RAW to role DBT_ROLE;
grant select on future tables in schema PROD_SPORTS.RAW to role DBT_ROLE;

grant all on database LUIS_NFL_DEMO to role DBT_ROLE;
grant all on all schemas in database LUIS_NFL_DEMO to role DBT_ROLE;
grant all on future schemas in database LUIS_NFL_DEMO to role DBT_ROLE;
-- dev builds create schemas such as DBT_<name>_STAGING in the same database, which DBT_ROLE can do via the grants above.

-- 4. Let Omni's role read what dbt builds (ANALYST is the role Omni's connection signs in with)
grant usage on database LUIS_NFL_DEMO to role ANALYST;
grant usage on schema LUIS_NFL_DEMO.STAGING to role ANALYST;
grant usage on schema LUIS_NFL_DEMO.MARTS to role ANALYST;
grant select on all tables in schema LUIS_NFL_DEMO.MARTS to role ANALYST;
grant select on future tables in schema LUIS_NFL_DEMO.MARTS to role ANALYST;
grant select on all views in schema LUIS_NFL_DEMO.STAGING to role ANALYST;
grant select on future views in schema LUIS_NFL_DEMO.STAGING to role ANALYST;
