{% macro log_generate_schema_name(custom_schema_name, node) -%}
    {#--
        logs output of generate_schema_name(custom_schema_name, node)
        i.e. dbt run-operation log_generate_schema_name --args '{ "custom_schema_name": "gold"}'
    --#}
    {{ log("Target: " ~ target.name) }}
    {{ log("Generated Schema name: " ~ generate_schema_name(custom_schema_name, node)) }}

{%- endmacro %}