  {% set post_class = 'post post-type-' + post.type | default('normal') %}
  {% if post_extra_class > 0 %}
    {% set post_class = post_class + ' ' + post_extra_class | default('') %}
  {% endif %}
  {% if post.sticky > 0 %}
    {% set post_class = post_class + ' post-sticky' %}
  {% endif %}

  {% if theme.reading_progress.enable && not is_index %}
    <div class="reading-progress-bar"></div>
  {% endif %}

  <article class="{{ post_class }}" itemscope itemtype="http://schema.org/Article">
  {##################}
  {### POST BLOCK ###}
  {##################}
  <div class="post-block">

    {# POST info #}
    <link itemprop="mainEntityOfPage" href="{{ config.url }}{{ url_for(post.path) }}"/>
    <span hidden itemprop="author" itemscope itemtype="http://schema.org/Person">
      <meta itemprop="name" content="{{ author }}"/>
      <meta itemprop="description" content="{{ description }}"/>
      <meta itemprop="image" content="{{ url_for( theme.avatar.url | default(theme.images + '/avatar.gif') ) }}"/>
    </span>
    <span hidden itemprop="publisher" itemscope itemtype="http://schema.org/Organization">
      <meta itemprop="name" content="{{ title }}"/>
    </span>

    {{ partial( '_partials/post/banner.swig') }}

      <header class="post-header">

        {# title #}
        {% if post.title %}
          <h2 class="post-title" itemprop="name headline">
           {% if post.link %}
              {% set postTitleIcon = '<i class="fa fa-external-link"></i>' %}
              {% set postText = post.title or post.link %}
              {{ next_url(post.link, postText + postTitleIcon, {class: 'post-title-link post-title-link-external', itemprop: 'url' }) }}
            {% else %}
              {% if is_index %}
                {{ next_url(post.path, post.title | default(__('post.untitled')), {class: 'post-title-link', itemprop: 'url' }) }}
              {% else -%}
                {{- post.title -}}
              {% endif %}
            {% endif %}
          </h2>
        {% endif %}

        <div class="post-meta">
          <span class="post-time">

            {% set date_diff = date(post.date) != date(post.updated) %}
            {% set time_diff = time(post.date) != time(post.updated) %}
            {% set datetime_diff = date_diff or time_diff %}

            {% if theme.post_meta.created_at %}
              <span class="post-meta-item-icon">
                <i class="fa fa-calendar-o"></i>
              </span>
              {% if theme.post_meta.item_text %}
                <span class="post-meta-item-text">{{ __('post.posted') }}</span>
              {% endif %}

              {% if !date_diff && time_diff && theme.post_meta.updated_at.enable && theme.post_meta.updated_at.another_day %}
                {% set create_title = __('post.created') + __('symbol.colon') + full_date(post.date) + ' / ' + __('post.modified') + __('symbol.colon') + time(post.updated) %}
              {% else %}
                {% set create_title = __('post.created') + __('symbol.colon') + full_date(post.date) %}
              {% endif %}

              <time title="{{ create_title }}" itemprop="dateCreated datePublished" datetime="{{ moment(post.date).format() }}">{#
              #}{{ date(post.date) -}}
              </time>
            {% endif %}

            {% if theme.post_meta.updated_at.enable && datetime_diff %}
              {% set display_updated = !theme.post_meta.updated_at.another_day || theme.post_meta.updated_at.another_day && date_diff %}

              {% if display_updated or !theme.post_meta.created_at %}
                {% if theme.post_meta.created_at and theme.post_meta.updated_at.enable %}
                <span class="post-meta-divider">|</span>
                {% endif %}

                <span class="post-meta-item-icon">
                  <i class="fa fa-calendar-check-o"></i>
                </span>
                {% if theme.post_meta.item_text %}
                  <span class="post-meta-item-text">{{ __('post.edited') }}</span>
                {% endif %}
                <time title="{{ __('post.modified') + __('symbol.colon') + full_date(post.updated) }}" itemprop="dateModified" datetime="{{ moment(post.updated).format() }}">{#
                #}{{ date(post.updated) -}}
                </time>
              {% endif %}
            {% endif %}
          </span>

          {% if post.categories and post.categories.length and theme.post_meta.categories %}
            <span class="post-category">
            {% if theme.post_meta.created_at or theme.post_meta.updated_at %}
              <span class="post-meta-divider">|</span>
            {% endif %}
              <span class="post-meta-item-icon">
                <i class="fa fa-folder-o"></i>
              </span>
              {% if theme.post_meta.item_text %}
                <span class="post-meta-item-text">{{ __('post.in') }}</span>
              {% endif %}
              {% for cat in post.categories %}
                <span itemprop="about" itemscope itemtype="http://schema.org/Thing">{#
                #}<a href="{{ url_for(cat.path) }}" itemprop="url" rel="index">{#
                  #}<span itemprop="name">{{ cat.name }}</span>{#
                #}</a>{#
              #}</span>

                {% set cat_length = post.categories.length %}
                {% if cat_length > 1 and loop.index !== cat_length %}
                  {{ __('symbol.comma') }}
                {% endif %}
              {% endfor %}
            </span>
          {% endif %}

          {% if post.comments %}
            {% set comments_count_post_enable = is_post() and theme.comments.count.post %}
            {% set comments_count_page_enable = not is_post() and theme.comments.count.page %}
            {% if theme.comments.type and (comments_count_post_enable or comments_count_page_enable) %}
              {% set comments_count_path = '_third-party/comments/' + theme.comments.type|lower + '/count.swig' %}
              {{ partial(comments_count_path,{ post: post }) }}
            {% endif %}
          {% endif %}

          {% if post.description %}
            <div class="post-description">{#
              #}{{ post.description }}{#
            #}</div>
          {% endif %}

        </div>
      </header>

    {#################}
    {### POST BODY ###}
    {#################}
    <div class="post-body{% if theme.han %} han-init-context{% endif %}{% if post.direction && post.direction.toLowerCase() === 'rtl' %} rtl{% endif %}" itemprop="articleBody">

      {% if is_index %}
        {% if post.excerpt %}
          {{ post.excerpt }}
          <!--noindex-->
          {% if theme.read_more_btn %}
            <div class="post-button text-center">
              <a class="btn" href="{{ url_for(post.path) }}{% if theme.scroll_to_more %}#more{% endif %}" rel="contents">
                {{ __('post.read_more') }} &raquo;
              </a>
            </div>
          {% endif %}
          <!--/noindex-->
        {% elif theme.auto_excerpt.enable %}
          {% set content = post.content | replace('<td class="gutter">.*?</td>', "", "g") | striptags %}
            <p>
              {{ content.substring(0, theme.auto_excerpt.length) }}
              {% if content.length > theme.auto_excerpt.length %}...{% endif %}
            </p>
          <!--noindex-->
          {% if theme.read_more_btn %}
            <div class="post-button text-center">
              <a class="btn" href="{{ url_for(post.path) }}{% if theme.scroll_to_more %}#more{% endif %}" rel="contents">
                {{ __('post.read_more') }} &raquo;
              </a>
            </div>
          {% endif %}
          <!--/noindex-->
        {% else %}
          {% if post.type === 'picture' %}
            <a href="{{ url_for(post.path) }}">{{ post.content }}</a>
          {% else %}
            {{ post.content }}
          {% endif %}
        {% endif %}
      {% else %}
        {{ post.content }}
      {% endif %}
    </div>

    {% if theme.related_posts.enable and (theme.related_posts.display_in_home or not is_index) %}
      {{ partial( '_partials/post/post-related.swig', { post: post }) }}
    {% endif %}

    {#####################}
    {### END POST BODY ###}
    {#####################}

    {% if theme.wechat_subscriber.enable and not is_index %}
      {{ partial( '_partials/post/wechat-subscriber.swig') }}
    {% endif %}

    {% if page.reward === undefined and theme.reward_settings.enable %}
      {% set reward_able = true %}
    {% else %}
      {% set reward_able = page.reward %}
    {% endif %}
    {% if reward_able and not is_index %}
      <div>
        {{ partial( '_partials/post/reward.swig') }}
      </div>
    {% endif %}

    {% if theme.creative_commons.license and theme.creative_commons.post and not is_index %}
      <div>
        {{ partial( '_partials/post/post-copyright.swig', { post: post }) }}
      </div>
    {% endif %}

    <footer class="post-footer">
      {% if post.tags and post.tags.length and not is_index %}
        <div class="post-tags">
          {% for tag in post.tags %}
            <a href="{{ url_for(tag.path) }}" rel="tag"># {{ tag.name }}</a>
          {% endfor %}
        </div>
      {% endif %}

      {% if not is_index %}
      {% if theme.rating.enable or (theme.vkontakte_api.enable and theme.vkontakte_api.like) or (theme.facebook_sdk.enable and theme.facebook_sdk.like_button) or theme.likely.enable or (theme.needmoreshare2.enable and theme.needmoreshare2.postbottom.enable) or (theme.baidushare and theme.baidushare.type === "button") %}
        <div class="post-widgets">
        {% if theme.rating.enable %}
          <div class="wp_rating">
            <div id="wpac-rating"></div>
          </div>
        {% endif %}

        {% if (theme.vkontakte_api.enable and theme.vkontakte_api.like) or (theme.facebook_sdk.enable and theme.facebook_sdk.like_button) %}
          {% if theme.rating.enable %}
            <span class="post-meta-divider">|</span>
          {% endif %}
          <div class="social-like">
            {% if theme.vkontakte_api.enable and theme.vkontakte_api.like %}
              <div class="vk_like">
                <span id="vk_like"></span>
              </div>
            {% endif %}

            {% if theme.facebook_sdk.enable and theme.facebook_sdk.like_button %}
              <div class="fb_like">
                <div class="fb-like" data-layout="button_count" data-share="true"></div>
              </div>
            {% endif %}
          </div>
        {% endif %}

        {% if theme.likely.enable or (theme.needmoreshare2.enable and theme.needmoreshare2.postbottom.enable) or (theme.baidushare.type === "button") %}
          {% if theme.rating.enable or (theme.vkontakte_api.enable and theme.vkontakte_api.like) or (theme.facebook_sdk.enable and theme.facebook_sdk.like_button) %}
            <span class="post-meta-divider">|</span>
          {% endif %}
          <div class="social_share">
            {% if theme.likely.enable %}
              <div>
                {{ partial( '_partials/share/likely.swig') }}
              </div>
            {% endif %}
            {% if theme.needmoreshare2.enable and theme.needmoreshare2.postbottom.enable %}
              <div id="needsharebutton-postbottom">
                <span class="btn">
                  <i class="fa fa-share-alt" aria-hidden="true"></i>
                </span>
              </div>
            {% endif %}
            {% if theme.baidushare.type === "button" %}
              <div>
                {{ partial( '_partials/share/baidushare.swig') }}
              </div>
            {% endif %}
          </div>
        {% endif %}
        </div>
      {% endif %}
      {% endif %}

      {% if not is_index and (post.prev or post.next) %}
        <div class="post-nav">
          <div class="post-nav-next post-nav-item">
            {% if post.next %}
              <a href="{{ url_for(post.next.path) }}" rel="next" title="{{ post.next.title }}">
                <i class="fa fa-chevron-left"></i> {{ post.next.title }}
              </a>
            {% endif %}
          </div>

          <span class="post-nav-divider"></span>

          <div class="post-nav-prev post-nav-item">
            {% if post.prev %}
              <a href="{{ url_for(post.prev.path) }}" rel="prev" title="{{ post.prev.title }}">
                {{ post.prev.title }} <i class="fa fa-chevron-right"></i>
              </a>
            {% endif %}
          </div>
        </div>
      {% endif %}

      {% set isLast = loop.index % page.per_page === 0 %}
      {% if is_index and not isLast %}
        <div class="post-eof"></div>
      {% endif %}
    </footer>
  </div>
  {######################}
  {### END POST BLOCK ###}
  {######################}
  </article>
