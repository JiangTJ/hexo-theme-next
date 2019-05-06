{{ partial('_partials/header/brand.swig', {}, {cache: theme.cache.enable}) }}
{{ partial( 'menu.swig') }}
{% for inject_name,inject_options in theme.injects.header %}
  {{ partial(inject_options.view) }}
{% endfor %}
