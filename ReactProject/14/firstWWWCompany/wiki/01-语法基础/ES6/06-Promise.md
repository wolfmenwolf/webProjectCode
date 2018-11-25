# Promise

## 语法

js 写异步一直是很意见很蛋疼的事，总是逃不开回调函数，即传说中的“callback hell”，例如

```js
function loadImg(src, callback, fail) {
    var img = document.createElement('img')
    img.onload = function () {
        callback(img)
    }
    img.onerror = function () {
        fail()
    }
    img.src = src
}

var src = 'http://www.imooc.com/static/img/index/logo_new.png'
loadImg(src, function (img) {
    console.log(img.width)
}, function () {
    console.log('failed')
})
```

使用 Promise 就是

```js
function loadImg(src) {
    const promise = new Promise(function (resolve, reject) {
        var img = document.createElement('img')
        img.onload = function () {
            resolve(img)
        }
        img.onerror = function () {
            reject()
        }
        img.src = src
    })
    return promise   
}

var src = 'http://www.imooc.com/static/img/index/logo_new.png'
var result = loadImg(src)

result.then(function (img) {
    console.log(img.width)
}, function () {
    console.log('failed')
})

result.then(function (img) {
    console.log(img.height)
})
```

## 兼容

Promise 在浏览器的兼容已经比较好了，某些不兼容的，可以引入 q.js 或者 bluebird.js

## 最后

后面会有 js 异步的深入介绍，到时候会详细介绍 Promise 的前生今世，这里显示一下语法。

**为何 Generator 不介绍**

Generator 语法和实现原理都比较复杂，很难理解。另外，它已经有了很成熟的替代方案，async/await（会再接下来的异步中详细介绍）。还有，它并不是为了解决异步这个问题而产生的，而是恰好被用来解决了异步，因此理解起来比较难。因此，Generator 会慢慢退出历史舞台，被更加简洁的东西代替。

