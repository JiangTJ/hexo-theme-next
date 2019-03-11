/* global hexo */

'use strict';

/**
 * Theme setting
 * netlify_lm:
 *   enable: true/false
 *   max_width:
 */
// hexo.extend.filter.register('after_post_render', function (data) {
//   var theme = hexo.theme.config;

//   if (!theme.lazyload) return;

//   var cheerio;

//   if (!cheerio) cheerio = require('cheerio');

//   var $ = cheerio.load(data.content, { decodeEntities: false });

//   $('img').each(function () {

//     let $image = $(this);
//     let imageLink = $image.attr('src');
//     $image.attr('data-src', imageLink);
//     //$image.removeAttr('src');
//     $image.attr('src', '/images/loading-l.gif');
//     $image.attr('class',  $image.attr('class')||'lazyload');

//   });

//   data.content = $.html();
// }, 1);

function doLazyload ($) { 
  $('img').each(function () {
    let $image = $(this);
    let imageLink = $image.attr('src');
    $image.attr('data-src', imageLink);
    //$image.removeAttr('src');
    $image.attr('src', '/images/loading-l.gif');
    $image.attr('class',  $image.attr('class')||'lazyload');
  });
}

module.exports = doLazyload;
