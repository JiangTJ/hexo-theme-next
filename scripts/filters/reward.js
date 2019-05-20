/* global hexo */

'use strict';

const path = require('path');

hexo.extend.filter.register('theme_inject', function(injects) {
  Object.keys(hexo.theme.config.reward).forEach((reward_name) => {
    let reward_item = hexo.theme.config.reward[reward_name];
    injects.reward.file(reward_name, path.join(__dirname,'../../layout/_partials/post/reward/simple.swig'), {
      reward_name,
      reward_item
    }, {cache: true});
  })
});