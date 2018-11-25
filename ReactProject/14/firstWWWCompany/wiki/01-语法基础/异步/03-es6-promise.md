# ES6 中的 Promise

## 回顾基本使用

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
}).then(function (img) {
    console.log(img.height)
})
```

## 异常捕获

以上 demo 中`then`中传递两个参数确实有点混乱，统一一下异常捕获

```js
// 规定：then 只接受一个参数，最后统一用 catch 捕获异常
result.then(function (img) {
    console.log(img.width)
}).then(function (img) {
    console.log(img.height)
}).catch(function (ex) {
    // 最后统一 catch
    console.log(ex)
})
```

## 多个串联

```js
var src1 = 'http://www.imooc.com/static/img/index/logo_new.png'
var result1 = loadImg(src1)
var src2 = 'https://avatars3.githubusercontent.com/u/9583120'
var result2 = loadImg(src2)

// 链式操作
result1.then(function (img) {
    console.log('第一个图片加载完成')
    return result2
}).then(function (img) {
    console.log('第二个图片加载完成')
}).catch(function (ex) {
    // 最后统一 catch
    console.log(ex)
})
```

多个串联更能看出 then 链式操作比 callback 更加有优势。不信，自己用 callback 的方式试一下。

## Promise.all & Promise.race

```js
// Promise.all 接收一个 promise 对象的数组
// 待全部完成之后，统一执行 success
Promise.all([result1, result2]).then(datas => {
    // 接收到的 datas 是一个数组，依次包含了多个 promise 返回的内容
    console.log(datas[0])
    console.log(datas[1])
})

// Promise.race 接收一个包含多个 promise 对象的数组
// 只要有一个完成，就执行 success
Promise.race([result1, result2]).then(data => {
    // data 即最先执行完成的 promise 的返回值
    console.log(data)
})
```

## 其他

社区里有一些 lib 如 Q.js bluebird.js 等，都对 Promise 进行了简单的封装，可以去看一下文档怎么用。

不过我觉得，现在标准的 Promise 已经很精简了，浏览器支持性也很好了（特别是移动端）
