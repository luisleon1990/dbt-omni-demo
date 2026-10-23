{#- In prod, build into the custom schema alone (STAGING, MARTS). Everywhere else, prefix it
    with the developer's target schema so dev builds never collide with prod. -#}
{% macro generate_schema_name(custom_schema_name, node) -%}
    {%- if custom_schema_name is none or target.name != 'prod' -%}
        {{ target.schema }}{{ '_' ~ custom_schema_name if custom_schema_name is not none else '' }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
