'use strict';

const fs = require('fs');
const path = require('path');

class Inject {
  constructor(){
    this.raws = [];
  }
  // getRaws(){
  //   return raws;
  // }
  raw(name, raw){
    this.raws.push({
      name,
      raw
    });
  }
  file(name, file){
    this.raws.push({
      name,
      raw: fs.readFileSync(file).toString()
    });
  }
}

const injectType = ['head', 'header', 'sidebar']

const injects = {}
injectType.forEach(item => {
  injects[item] = new Inject();
})

hexo.on('generateBefore', function() {

  // Only support Gemini.
  hexo.theme.config.scheme = 'Gemini';

  hexo.execFilterSync('theme_inject', injects);
  hexo.theme.config.injects = {};
  injectType.forEach(type => {
    hexo.theme.config.injects[type] = []
    injects[type].raws.forEach(injectObj => {
      let viewName = `inject/${type}/${injectObj.name}.swig`;
      hexo.theme.setView(viewName, injectObj.raw);
      hexo.theme.config.injects[type].push({
        name: viewName
      });
    });
  });

});
