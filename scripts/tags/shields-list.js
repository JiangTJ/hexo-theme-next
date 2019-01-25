/**
 * button.js | https://theme-next.org/docs/tag-plugins/button/
 */

/* global hexo */

'use strict';

const fs = require('fs');
const util = require('hexo-util');
const yaml = require('js-yaml');

function renderShields(args) {
  let filePath = args[0];
  let htmlTag = util.htmlTag;

  if (!filePath) {
    hexo.log.warn('FilePath can NOT be empty');
  }

  if (!filePath.indexOf('/') == 0) {
    filePath = 'source/_data/' + filePath
  }

  if (!filePath.lastIndexOf('.yml') == 0) {
    filePath = filePath + '.yml'
  }

  let config = yaml.safeLoad(fs.readFileSync(filePath));

  let items = Object.keys(config).map((key) => {
    let value = config[key];
    let aArgs = {
      href: value.href,
      target: value.href||'_blank'
    }
    value.src = value.src || 'https://img.shields.io/badge/'+ encodeURI(value.name||key) + '-' + encodeURI(value.des) + '-' + encodeURI(value.color) + '.svg'
    let imgArgs = {
      style: 'margin:0;float:left;',
      src: value.src,
      alt: value.alt||key,
      title: value.title
    }
    //<img style="margin:0;float:left;" src="https://img.shields.io/badge/Mail-@dnocm-blue.svg" alt="Mail">
    return htmlTag('a',aArgs,
      htmlTag('img',imgArgs)
    );
  })
  items.push('<div style="clear:both;"></div>')
  return items.join('');
}

hexo.extend.tag.register('shields', renderShields, { ends: false });
hexo.extend.tag.register('shields-list', renderShields, { ends: false });
