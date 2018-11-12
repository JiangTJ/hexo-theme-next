{% macro render(name, value) %}
{% import 'menu-badge.swig' as menu_badge %}

  {% set itemURL = value.split('||')[0] | trim %}
  {% if itemURL.indexOf("http") != 0 %}
    {% set itemURL = itemURL | replace('//', '/', 'g') %}
  {% endif %}
  <li class="menu-item menu-item-{{ itemName | replace(' ', '-', 'g') }}{{ item_active(itemURL, 'menu-item-active') }}">
    <a href="{{ url_for(itemURL) }}" rel="section">
    {%- if theme.menu_settings.icons %}
      <i class="menu-item-icon fa fa-fw fa-{{ value.split('||')[1] | trim | default('question-circle') }}"></i> <br />{#
  #}{% endif %}

    {{- __('menu.' + name ) | replace('menu.', '') -}}

    {%- if theme.menu_settings.badges -%}
      {{- menu_badge.render(name) | trim -}}
    {%- endif -%}

    </a>
  </li>

{% endmacro %}
