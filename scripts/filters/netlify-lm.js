/* global hexo */

'use strict';

/**
 * Theme setting
 * netlify_lm:
 *   enable: true/false
 *   max_width:
 */
// hexo.extend.filter.register('after_render:html', function (data) {
//   var theme = hexo.theme.config;

//   if (!theme.netlify_lm) return;

//   if (!theme.netlify_lm.enable) return;

//   var cheerio;

//   if (!cheerio) cheerio = require('cheerio');

//   var $ = cheerio.load(data, { decodeEntities: false });

//   $('head').each(function () {
//     let $head = $(this);
//     $head.append('<script src="https://cdn.jsdelivr.net/npm/lozad@1.9.0/dist/lozad.min.js" integrity="sha256-50cmb3K6Zka/WMfXLFzqyo5+P+ue2JdsyEmSEsU58s4=" crossorigin="anonymous"></script>\n');
//   });

//   $('img').each(function () {

//     let $image = $(this);
//     let imageLink = $image.attr('src');
//     if (!imageLink || imageLink.indexOf('nf_resize=') >= 0) return;


//     let width = $image.attr('width');
//     let height = $image.attr('height');
//     let whList = [];
//     if(width){
//       whList.push('w=' + width);
//     }
//     if(height){
//       whList.push('h=' + height);
//     }
//     if (whList.length > 0) {
//       if (imageLink.indexOf('?') < 0) {
//         imageLink += '?';
//       }
//       $image.attr('src', imageLink + "nf_resize=fit&" + whList.join("&"));
//       return;
//     }

//     if (theme.netlify_lm.max_width) {
//       if (imageLink.indexOf('?') < 0) {
//         imageLink += '?';
//       }
//       $image.attr('src', imageLink + "nf_resize=fit&w=" + theme.netlify_lm.max_width);
//     }
//   });

//   return $.html();
// });

function doNetlifyLM ($) { 

  // $('head').each(function () {
  //   let $head = $(this);
  //   $head.append('<script src="https://cdn.jsdelivr.net/npm/lozad@1.9.0/dist/lozad.min.js" integrity="sha256-50cmb3K6Zka/WMfXLFzqyo5+P+ue2JdsyEmSEsU58s4=" crossorigin="anonymous"></script>\n');
  // });

  let config = {
    maxWidth: null
  };

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

    if (config.maxWidth) {
      if (imageLink.indexOf('?') < 0) {
        imageLink += '?';
      }
      $image.attr('src', imageLink + "nf_resize=fit&w=" + config.maxWidth);
    }
  });

}

module.exports = doNetlifyLM;
