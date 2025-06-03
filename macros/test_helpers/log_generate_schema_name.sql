{% macro log_generate_schema_name(custom_schema_name, node) -%}
    {#--
        logs output of generate_schema_name(custom_schema_name, node)
        i.e. dbt run-operation log_generate_schema_name --args '{ "custom_schema_name": "gold"}'
    --#}
    {{ log("DBT_ENVIRONMENT: " ~ env_var('DBT_ENVIRONMENT'), info=True) }}
    {{ log("Generated Schema name: " ~ generate_schema_name(custom_schema_name, node), info=True) }}

{%- endmacro %}