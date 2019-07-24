/* global hexo */

'use strict';

hexo.extend.filter.register('theme_inject', function(injects) {
  let theme = hexo.theme.config;
  if (!theme.utteranc.enable) return;

  injects.bodyEnd.raw('utteranc', `
  {% if page.comments %}
  <script src="https://utteranc.es/client.js"
        repo="{{ theme.utteranc.repo }}"
        issue-term="{{ theme.utteranc.pathname }}"
        theme="{{ theme.utteranc.theme }}"
        crossorigin="anonymous"
        async>
  </script>
  {% endif %}
  `);

});
