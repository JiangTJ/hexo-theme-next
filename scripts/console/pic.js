const imagemin = require('imagemin');
const imageminWebp = require('imagemin-webp');
const fs = require('fs');
var path = require('path');

function webpAllPic(root) {
    fs.readdir(root, {
        withFileTypes: true
    }, function (err, files) {
        if (err) {
            console.error(err);
            return;
        }
        //console.log(files);
        files.forEach(item => {
            let temp = path.join(root, item.name);
            if (item.isFile()) {
                let pic = new RegExp('(.jpeg|.png|.jpg)$', 'gi');
                if (pic.test(item.name)) {
                    //console.error(temp);
                    imagemin([temp], root, {
                        use: [imageminWebp({ quality: 75 })]
                    }).then(() => {
                        console.log('Images optimized: ' + temp);
                    });
                }
            } else {
                webpAllPic(temp);
            }
        });
    });
}

function cleanPic(root) {
    fs.readdir(root, {
        withFileTypes: true
    }, function (err, files) {
        if (err) {
            console.error(err);
            return;
        }
        files.forEach(item => {
            let temp = path.join(root, item.name);
            if (item.isFile()) {
                let pic = new RegExp('(.jpeg|.png|.jpg)$', 'gi');
                if (pic.test(item.name)) {
                    let end = temp.lastIndexOf('.');
                    fs.exists(temp.substring(0, end) + '.webp', (exists) => {
                        if (exists) {
                            fs.unlink(temp, (err) => {
                                if (err) throw err;
                                console.log('Deleted: ' + temp);
                            });
                        } else {
                            console.warn('webp not exist: ' + temp);
                        }
                    });
                }
            } else {
                cleanPic(temp);
            }
        });
    });
}

hexo.extend.console.register('webp', '压缩，转换至webp格式', {
    arguments: [
        { name: 'path', desc: '压缩路径（相对于_post）' }
    ],
    options: [
      {name: '-a, --all', desc: '转换所有`source/_post`下的图片至webp格式'},
      {name: '-c, --clean', desc: '删除所有`source/_post`下已转换的图片'},
      {name: '--images', desc: '转换`source/images`下的图片至webp格式'},
      {name: '--path', desc: '自定义路径（完整）'}
    ]
}, function (args) {
    console.log(args);
    let path = "";

    // all
    if (args.a || args.all) {
        webpAllPic('source/_posts');
        return;
    }

    // clean
    if (args.c || args.clean) {
        cleanPic('source/_posts');
        return;
    }

    // images dir
    if (args.images) {
        path = 'source/images';
    }

    // post path
    if (args._[0]) {
        if (hexo.config.post_base_dir) {
            path = 'source/_posts/' + hexo.config.post_base_dir + '/' + args._[0];
        } else {
            path = 'source/_posts/' + args._[0];
        }
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

    if (!path) {
        console.log('路径不能为空！')
        return this.call('help', {_: ['webp']});
    }

    //webp
    imagemin([path + type], path, {
        use: [
            imageminWebp({ quality: 75 })
        ]
    }).then(() => {
        console.log('Images optimized');
    });

});
