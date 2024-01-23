{% macro get_dbt_nodes() %}
  
  {# 
  This macro parses the dbt model graph and returns all tables and views
  
  Note:
  Only models materialized as view, table or incremental and seeds are considered. 
  Incremental models and seeds are treated as tables. 
  #}

  {{ log( 'get_dbt_nodes: Loading views and tables from dbt graph' , info=true) }}  
  {% set dbt_tables_and_views = [] %}
  {% set table_materializations = ["table", "incremental", "seed"] %}
  {% set all_materializations = ["view", "table", "incremental", "seed"] %}
  {% set table_resource_types = ["model", "seed"] %}
  
  {% for node in graph.nodes.values() %}    
    {% if node.resource_type in table_resource_types and node.config.get('materialized', 'none') in all_materializations %}

    {# Set the table/view name as alias instead of node name if alias exists #}
    {% set node_name = node.config.get('alias') if node.config.get('alias') else node.name %}
      
      {# Set the node_type type as either table or view. #}
      {% if node.config.get('materialized', 'table') in table_materializations %}
        {% set node_type = "table" %}
      {% else %}
        {% set node_type = "view" %}
      {% endif %}
      
      {% set node = {'schema': node.schema.upper(), 'name': node_name, 'type': node_type} %}
      {{ log( node , info=true) }}
      {% do dbt_tables_and_views.append(node) %}
    {% endif %}
  {% endfor %}

  {{ return(dbt_tables_and_views) }}
{% endmacro %}