/* global hexo */

'use strict';

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
