<div id="posts" class="posts-expand posts-categories-right">
  <div class="post-block page">

<!-- Tag Header -->
<header class="post-header">
<{% if theme.seo %}h2{% else %}h1{% endif %} class="post-title" itemprop="name headline">
  标签
  {% include '../_partials/post-edit.swig' %}
</{% if theme.seo %}h2{% else %}h1{% endif %}>
<div class="post-meta">
  {% include '../_partials/page/breadcrumb.swig' %}
</div>
</header>

    <div class="post-body{% if theme.han %} han-init-context{% endif %}{% if page.direction && page.direction.toLowerCase() === 'rtl' %} rtl{% endif %}">
      <div class="tag-cloud">
        <div class="tag-cloud-title">
          {% set visibleTags = 0 %}
          {% for tag in site.tags %}
            {% if tag.length %}
              {% set visibleTags += 1 %}
            {% endif %}
          {% endfor %}
          {{ _p('counter.tag_cloud', visibleTags) }}
        </div>
        <div class="tag-cloud-tags">
          {{ tagcloud({min_font: 12, max_font: 30, amount: 300, color: true, start_color: '#ccc', end_color: '#111'}) }}
        </div>
      </div>
    </div>
  </div>
</div>