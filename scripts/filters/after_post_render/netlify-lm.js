/* global hexo */

'use strict';

/**
 * Theme setting
 * netlify_lm:
 *   enable: true/false
 *   max_width:
 */
hexo.extend.filter.register('after_post_render', function (data) {
  var theme = hexo.theme.config;

  if (!theme.netlify_lm.enable) return;

  var cheerio;

  if (!cheerio) cheerio = require('cheerio');

  var $ = cheerio.load(data.content, { decodeEntities: false });

  $('img').each(function () {

    let $image = $(this);
    let imageLink = $image.attr('src');
    if (!imageLink || imageLink.indexOf('nf_resize=') >= 0) return;


    let width = $image.attr('width');
    let height = $image.attr('height');
    let whList = [];
    if(width){
      whList.push('w=' + width);
    }
    if(height){
      whList.push('h=' + height);
    }
    if (whList.length > 0) {
      if (imageLink.indexOf('?') < 0) {
        imageLink += '?';
      }
      $image.attr('src', imageLink + "nf_resize=fit&" + whList.join("&"));
      return;
    }

    if (theme.netlify_lm.max_width) {
      if (imageLink.indexOf('?') < 0) {
        imageLink += '?';
      }
      $image.attr('src', imageLink + "nf_resize=fit&w=" + theme.netlify_lm.max_width);
    }
  });

  data.content = $.html();
}, 0);
