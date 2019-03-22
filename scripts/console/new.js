/**
 * hexo x name
 */
hexo.extend.console.register('x', '在指定路径创建文件', {
  arguments: [
    {name: 'title', desc: '标题名'}
  ]
}, function(args){
  console.log(args);
  args.path = hexo.config.post_base_dir + '/' + args._[0];
  this.call('new',args)
});
