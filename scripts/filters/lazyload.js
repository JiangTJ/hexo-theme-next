/* global hexo */

'use strict';

function doLazyload ($) { 

  /**
   *     ~ 413 380
   * 413 ~ 567 528
   * 567 ~ 1200 640
   * 1201 ~ 1600 820
   * 1601 ~ + 1120
   */
  let responsiveWidth = [
    [413,380],
    [567,528],
    [1200,640],
    [1600,820],
    [1601,1120]
  ]

  $('img').each(function () {
    let $image = $(this);
    let imageLink = $image.attr('src');
    //$image.attr('data-src', imageLink);
    //$image.removeAttr('src');
    imageLink = imageLink.split('?')[0];
    $image.attr('src', `${imageLink}?nf_resize=fit&w=256`);
    $image.attr('class',  $image.attr('class')||'lozad');

    let width = $image.attr('width');
    if (width) {
      $image.css("width",width + "px"); 
    }

    let srcsetList = [];
    responsiveWidth.forEach(item => {
      if (width && width<item[1]) {
        srcsetList.push(`${imageLink}?nf_resize=fit&w=${width} ${item[0]}w`)
        return;
      }
      srcsetList.push(`${imageLink}?nf_resize=fit&w=${item[1]} ${item[0]}w`)
    })
    $image.attr('data-srcset', srcsetList.join(','));
  });
}

module.exports = doLazyload;
