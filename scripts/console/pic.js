const imagemin = require('imagemin');
const imageminWebp = require('imagemin-webp');

hexo.extend.console.register('webp', '压缩', {
    arguments: [
        { name: 'path', desc: '压缩路径' }
    ]
}, function (args) {
    console.log(args);
    let path = "";

    // images dir
    if (args.all) {
        path = 'source/images';
    }
    
    // post path
    if (args._[0]) {
        path = 'source/_posts/' + hexo.config.post_base_dir + '/' + args._[0];
    }

    // custom path
    if (args.path) {
        path = args.path;
    }
    
    // custom type
    let type = '/*';
    if (args.type) {
        type = `/*.{${args.type}}`;
    }

    //webp
    imagemin([path + type], path, {
        use: [
            imageminWebp({quality: 75})
        ],
        nocase: true
    }).then(() => {
        console.log('Images optimized');
    });

});
