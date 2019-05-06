{{ partial('_partials/header/brand.swig', {}, {cache: theme.cache.enable}) }}
{{ partial( 'menu.swig') }}
{% for custom_header in theme.injects.header %}
  {{ partial(custom_header.name) }}
{% endfor %}
