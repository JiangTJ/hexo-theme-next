<div align="right">Language: :us:
<a title="Chinese" href="docs/zh-CN/README.md">:cn:</a></div>

# Hexo Theme Cake

:fish_cake: It's a lovely theme, based on [NexT](https://github.com/theme-next/hexo-theme-next).

<img src="https://img.shields.io/badge/hexo-%3E%3D%203.5.0-blue.svg">

## Todo List
- [x] Add new filter `theme_inject`. For custom head header and sidebar (comment post_mate in future);
- [x] Refactor commment.
- [x] Replace include to partial.
- [x] Replace import to partial.
- [x] Remove many feature....(I don't use or it can be impl with inject in the future)
- [ ] Refactor style ui etc. (doing)
- [ ] Remove Muse Mist Pisces. (doing)
- [ ] Refactor fonts.
- [ ] Refactor post_mate.
- [ ] Fix issue the categories/tags count contains _drafts.


## Feature

Speed(i7-6700K SATA-SSD)
- origin(next:7.1.0) 242 files generated ≈≈ 6.5 s
- new                241 files generated ≈≈ 3.8 s

Speed(i5-6200U PCIE-SSD)
- origin(next:7.1.0) 242 files generated ≈≈ 12 s
- new                241 files generated ≈≈ 8.5 s

Inject
```js
hexo.extend.filter.register('theme_inject', function(injects) {
  injects.head.file('custom', 'source/_data/head.swig', {}, {cache: true});
  injects.sidebar.raw('custom', 'Put some in sidebar!');
});
```
