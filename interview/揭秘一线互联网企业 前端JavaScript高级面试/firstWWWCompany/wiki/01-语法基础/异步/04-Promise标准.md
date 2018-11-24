# Promise/A+ 标准

> 任何技术、方案、语言（库和框架除外）等，要推广到所有人使用，肯定是有一套标准支持的。例如 html css js http 等。无规矩不成方圆，任何不符合标准的东西（或者说长久推广并未形成标准），都会被大家抛弃。就如当初的 IE 浏览器

> 联想到近期微信小程序推出 webview，允许加载 h5 页面。看到有人评论“任何不符合标准的都是异教徒”。

## 总结

网上搜一下“Promise/A+ 标准”就可以找到很多资源，总结一下：

- 状态可能有三种状态：等待（pending）、已完成（fulfilled）、已拒绝（rejected）
    - promise 
    - promise 的状态只可能从“等待”转到“完成”态或者“拒绝”态，不能逆向转换，同时“完成”态和“拒绝”态不能相互转换
- then
    - promise 必须实现then方法，而且then必须返回一个 promise ，同一个 promise 的then可以调用多次（链式），并且回调的执行顺序跟它们被定义时的顺序一致
    - then方法接受两个参数，第一个参数是成功时的回调，在 promise 由“等待”态转换到“完成”态时调用，另一个是失败时的回调，在 promise 由“等待”态转换到“拒绝”态时调用

## 状态

通过以下 demo 讲解状态的变化，一开始是`pending`，然后`resolve(img)`或者`reject()`。注意：**状态变化不可逆**

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
```

## then

参考一下 demo ，`result`就是一个 Promise 对象，它有 then 方法。第一个参数。。。。第二个参数。。。。

```js
var result = loadImg(src)
result.then(function (img) {
    console.log(img.width)
}, function () {    
    console.log('failed')
}).then(function (img) {
    console.log(img.height)
})
```

另外，then 方法必须返回一个 promise ，上面 demo 没写 return ，它就会返回自身。当然你可以自己手写 return

```js
result1.then(function (img) {
    console.log('第一个图片加载完成')
    return result2
}).then(function (img) {
    console.log('第二个图片加载完成')
})
```
