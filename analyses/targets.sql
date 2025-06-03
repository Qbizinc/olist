{%- set custom_schema_name = 'bronze' -%}
select 
    '{{ target.name }}' as target_name,
    '{{ target.schema }}' as target_schema, 
    '{{ custom_schema_name }}'  as custom_schema, 
    '{{generate_schema_name(custom_schema_name, none)}}' as generated_schema_name