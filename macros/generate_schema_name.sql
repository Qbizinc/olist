{% macro generate_schema_name(custom_schema_name, node) -%}
    {#--
        changing how dbt sets schema name 
        https://docs.getdbt.com/docs/build/custom-schemas#how-does-dbt-generate-a-models-schema-name

        Args:
            custom_schema_name (str): The schema name defined in dbt_project.yml or for a specific node
            node (dict): The node that is currently being processed by dbt
    --#}

    {%- set default_schema = target.schema -%}
    {%- set env_name = env_var('DBT_ENVIRONMENT') | lower -%}
    
    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {%- else -%}
        {%- if env_name == 'prod' -%}
            {{- custom_schema_name | trim -}}
        {%- else -%}
            {# default dbt behavior #}
            {{- default_schema -}}_{{- custom_schema_name | trim -}}
        {%- endif -%}
    {%- endif -%}

{%- endmacro %}