hexo.extend.filter.register('after_post_render', function (data) {

  var cheerio;

  if (!cheerio) cheerio = require('cheerio');

  var $ = cheerio.load(data.content, { decodeEntities: false });
  //require('./netlify-lm')($);
  require('./lazyload')($);
  data.content = $.html();

}, 0);