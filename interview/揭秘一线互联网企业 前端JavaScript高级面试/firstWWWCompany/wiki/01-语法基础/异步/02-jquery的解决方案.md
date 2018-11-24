# jquery 的解决方案

## callback hell

jquery 1.5 之前，写 ajax 是这样写的

```js
var ajax = $.ajax({
    url: 'data.json',
    success: function () {
        console.log('success1')
        console.log('success2')
        console.log('success3')
    },
    error: function () {
        console.log('error')
    }
})
console.log(ajax) // 返回一个 XHR 对象
```

带来问题 callback hell

##  jquery 1.5

```js
var ajax = $.ajax('data.json')
ajax.done(function () {
        console.log('success 1')
    })
    .fail(function () {
        console.log('error')
    })
    .done(function () {
         console.log('success 2')
    })
console.log(ajax) // 返回一个 deferred 对象
```

也可以这样写（很像 Promise 的写法）

```js
// 很像 Promise 的写法
var ajax = $.ajax('data.json')
ajax.then(function () {
        console.log('success 1')
    }, function () {
        console.log('error 1')
    })
    .then(function () {
        console.log('success 2')
    }, function () {
        console.log('error 2')
    })
```

因此，我们现在学习的 Promise ，早在 jquery 1.5 的时候就已经实践过了。时间也证明这是目前的一个自荐方式，加入 ES6 大家庭，并且有了 Promise/A+ 标准。

## 从设计原则说

无论是 jquery 还是现在的 Promise ，都无法改变 js 单线程、异步这样的特性。但是从代码编写方式上杜绝了之前的 callback hell

作重要的设计原则就是“开放封闭原则” —— 对扩展开放、对修改封闭。这里就能很好的体现。

