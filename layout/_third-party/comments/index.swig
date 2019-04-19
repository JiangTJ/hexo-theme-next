{% if theme.disqus.enable %}
  {{ partial( 'disqus.swig') }}
{% elif theme.changyan.enable and theme.changyan.appid and theme.changyan.appkey %}
  {{ partial( 'changyan.swig') }}
{% elif theme.valine.enable and theme.valine.appid and theme.valine.appkey %}
  {{ partial( 'valine.swig') }}
{% endif %}

{% if page.comments %}
  {% if theme.livere_uid %}
    {{ partial( 'livere.swig') }}
  {% elif theme.gitment.enable and theme.gitment.client_id %}
    {{ partial( 'gitment.swig') }}
  {% elif theme.gitalk.enable %}
    {{ partial( 'gitalk.swig') }}
  {% endif %}
{% endif %}
