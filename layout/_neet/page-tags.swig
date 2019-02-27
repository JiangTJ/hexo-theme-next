<div class="post-block page">

<!-- Tag Header -->
<header class="post-header">
<{% if theme.seo %}h2{% else %}h1{% endif %} class="post-title" itemprop="name headline">
  标签
  {% include '../_partials/post-edit.swig' %}
</{% if theme.seo %}h2{% else %}h1{% endif %}>
<!-- <div class="post-meta">
  {% include '../_partials/page/breadcrumb.swig' %}
</div> -->
</header>

    <div class="post-body{% if theme.han %} han-init-context{% endif %}{% if page.direction && page.direction.toLowerCase() === 'rtl' %} rtl{% endif %}">
      <div class="category-all-page">
        <div class="category-all-title">
          {% set visibleTags = 0 %}
          {% for tag in site.tags %}
            {% if tag.length %}
              {% set visibleTags += 1 %}
            {% endif %}
          {% endfor %}
          {{ _p('counter.tag_cloud', visibleTags) }}
        </div>
        <div class="category-all">
          {{ list_tags({class:'category',orderby:'length',order:-1}) }}
        </div>
      </div>
    </div>
</div>

