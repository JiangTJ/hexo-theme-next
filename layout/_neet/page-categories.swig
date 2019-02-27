<div class="post-block page">

<!-- Tag Header -->
<header class="post-header">
<{% if theme.seo %}h2{% else %}h1{% endif %} class="post-title" itemprop="name headline">
  分类
  {% include '../_partials/post-edit.swig' %}
</{% if theme.seo %}h2{% else %}h1{% endif %}>
<!-- <div class="post-meta">
  {% include '../_partials/page/breadcrumb.swig' %}
</div> -->
</header>

    <div class="post-body{% if theme.han %} han-init-context{% endif %}{% if page.direction && page.direction.toLowerCase() === 'rtl' %} rtl{% endif %}">
      <div class="category-all-page">
        <div class="category-all-title">
          {% set visibleCategories = 0 %}
          {% for cat in site.categories %}
            {% if cat.length %}
              {% set visibleCategories += 1 %}
            {% endif %}
          {% endfor %}
          {{ _p('counter.categories', visibleCategories) }}
        </div>
        <div class="category-all">
          {{ list_categories() }}
        </div>
      </div>
    </div>
</div>

