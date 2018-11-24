# jquery 中的 promise

## 提问

给出一段非常简单的异步操作代码，使用setTimeout函数。

```js
// 给出一段非常简单的异步操作代码，使用setTimeout函数
var wait = function () {
    var task = function () {
        console.log('执行完成')
    }
    setTimeout(task, 2000)
}
wait()

// 新增需求：要在执行完成之后进行某些特别复杂的操作，代码可能会很多，而且分好几个步骤
```

但是我如果再加一个需求 ———— 要在执行完成之后进行某些特别复杂的操作，代码可能会很多，而且分好几个步骤 ———— 那该怎么办？

当然，其中一个答案就是：直接在 task 函数中写这些复杂的操作 ——但是很不符合设计原则

## $.Deferred

首先引用 jquery

```js
function waitHandle() {
    var dtd = $.Deferred()  // 创建一个 deferred 对象

    var wait = function (dtd) {  // 要求传入一个 deferred 对象
        var task = function () {
            console.log('执行完成')
            dtd.resolve()  // 表示异步任务已经完成
            // dtd.reject() // 表示异步任务失败或出错
        }
        setTimeout(task, 2000)
        return dtd  // 要求返回 deferred 对象
    }

    // 注意，这里一定要有返回值
    return wait(dtd)
}
```

解释一下上面的代码，有点绕，关键点：

- 对之前的 wait 函数又进行了封装
- 创建`var dtd = $.Deferred()`
- `wait(dtd)`，并且传入`dtd`，最终返回
- wait 函数内，成功后执行`dtd.resolve()`
- wait 函数最终返回`dtd`

怎么使用？

```js
var w = waitHandle()
w.then(function () {
    console.log('ok 1')
}, function () {
    console.log('err 1')
}).then(function () {
    console.log('ok 2')
}, function () {
    console.log('err 2')
})

// 还有 w.done w.fail
```

这样的使用方式，再结合此前的需求，就能完美解决

## $.Promise

`dtd`的 API 可以分成两组

- `dtd.resolve` `dtd.reject`
- `dtd.then` `dtd.done` `dtd.fail`

这两组应该分开的，因为他们的用意不一样，混合在一起会出问题。例如最后代码最后执行`w.reject()`试试

> 也顺便介绍一下系统设计的时候，拆分、封装的必要

那如何解决？—— Promise 浮出水面

```js
function waitHandle() {
    var dtd = $.Deferred()
    var wait = function (dtd) {
        var task = function () {
            console.log('执行完成')
            dtd.resolve()
        }
        setTimeout(task, 2000)
        return dtd.promise()  // 注意，这里返回的是 primise 而不是直接返回 deferred 对象
    }
    return wait(dtd)
}

var w = waitHandle() // 经过上面的改动，w 接收的就是一个 promise 对象
$.when(w)
 .then(function () {
    console.log('ok 1')
 })
 .then(function () {
    console.log('ok 2')
 })

// w.reject()  // 执行这句话会直接报错
```

promise 对象只有`then` `done` `fail`这些被动监听的方法，没有`resolve` `reject`这些主动触发的方法



