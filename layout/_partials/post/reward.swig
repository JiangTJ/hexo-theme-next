{% spaceless %}
<div id="reward-container">
  <div>{{ theme.reward_settings.comment }}</div>
  <div class="reward-group">
  {% for reward_item in theme.reward %}
    <a class="reward-button">
      {% if reward_item.icon %}<i class="fa fa-{{reward_item.icon}}" aria-hidden="true"></i>{% else %}{{reward_item.name}}{% endif %}
    </a>
  {% endfor %}
  </div>


  {#
  <button id="reward-button" disable="enable" onclick="var qr = document.getElementById(&quot;qr&quot;); qr.style.display = (qr.style.display === 'none') ? 'block' : 'none';">
    {{ __('reward.donate') }}
  </button>

    <div id="qr" style="display: none;">

    {% for reward_item in theme.reward %}
      <div style="display: inline-block">
        <img src="{{ url_for(image) }}" alt="{{ author }} {{ reward_item.name }}"/>
        <p>{{ translation }}</p>
      </div>
    {% endfor %}
  #}
  </div>
</div>
{% endspaceless %}