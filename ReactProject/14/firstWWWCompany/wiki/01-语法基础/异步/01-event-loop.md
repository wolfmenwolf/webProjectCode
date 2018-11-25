# event loop

## demo

以下代码打印的顺序，分别是怎样的

```js
// 加载图片
var src = 'http://www.imooc.com/static/img/index/logo_new.png'
function loadImg(src, callback) {
    var img = document.createElement('img')
    img.onload = function () {
        callback(img)
    }
    img.src = src
}

console.log(100)
loadImg(src, function () {
    console.log(200)
})
console.log(300)
setTimeout(function () {
    console.log(400)
}, 100)
setTimeout(function () {
    console.log(500)
})
```

我这边测试的结果是 `100 300 200 500 400` ，你的测试结果可能会不一样，因为`200`的位置，毕竟每个人的网速不一样，加载图片有快慢之分。

## 单线程

JavaScript语言的一大特点就是单线程，也就是说，同一个时间只能做一件事。

```js
// 循环运行期间，JS 执行和 DOM 渲染暂时卡顿
var i, sum = 0;
for (i = 0; i < 1000000000; i++) {
    sum += i;
}
console.log(sum);

// alert 不处理，JS 执行和 DOM 渲染暂时卡顿
console.log(1)
alert('hello')
console.log(2)
```

为何只有单线程？—— 因为如果是多线程渲染 DOM 就乱套了（其他语法的多线程，数据同步也是一个难点）。因此 JS 执行的时候，浏览器会卡顿，浏览器会等着 JS 执行完（防止有 DOM 渲染操作）在去做 DOM 渲染。

这样的机制，才让 JS 有异步。你会发现，当加载不出资源（图片、视频）时候，浏览器肯定不会卡死。但是你写一个 js 死循环，浏览器就卡死了。

> 为了解决这个问题，html5 提出了 web worker 能直线多线程，但是新启的线程，不允许操作 DOM （有可以看出是因为 DOM 操作的冲突才不得不用单线程）

```js
// 例一
console.log(100)
setTimeout(function () {
    console.log(200)       // 反正 1000ms 之后执行
}, 1000)                   // 先不管它，先让其他 JS 代码运行
console.log(300)
console.log(400)

// 例二
console.log(100)
$.ajax({
    url: 'xxxxx',
    success: function (result) {  // ajax 加载完才执行
        console.log(result)       // 先不管它，先让其他 JS 代码运行
    }
})
console.log(300)
console.log(400)
```

## event-loop

将 js 中要执行的每个任务都做一个划分，同步执行的放在“执行栈”，而异步执行的**将**放在（不是马上就放进去）“异步队列”。然后，将“执行栈”放在主线程中执行，挨个任务排队执行，执行到最后就立马去看“异步队列”是否有数据？有数据就拿到主线程中执行，执行完再去看“异步队列”是否有数据？

那么，异步执行任务何时被放在“异步队列”中呢？以上面的 demo 为例。第一个，图片加载完成时；第二，100ms 后；第三，立刻。

按照这个逻辑，再去看一遍 demo 代码的打印顺序，就彻底明白了。

这个过程就是所谓的 event-loop

新增：event-loop 过程示例分析

```js
// 示例 1
setTimeout(function () {
    console.log(100)
})
console.log(200)

// 示例 2
setTimeout(function () {
    console.log(1)
}, 100)
setTimeout(function () {
    console.log(2)
})
console.log(3)

// 示例 3
$.ajax({
    url: 'xxxxx',
    success: function () {
        console.log('a')
    }
})
setTimeout(function () {
    console.log('b')
}, 100)
setTimeout(function () {
    console.log('c')
})
console.log('d')
```
