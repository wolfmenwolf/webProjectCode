# MVVM 响应式

## 目录

- 什么是响应式
- `Object.defineProperty`
- 模拟实现

## 什么是响应式

```html
    <div id="app">
        <p>{{price}}</p>
        <p>{{name}}</p>
    </div>
    
    <script src="https://cdn.bootcss.com/vue/2.5.9/vue.js"></script>
    <script>
        var vm = new Vue({
            el: '#app',
            data: {
                price: 100,
                name: 'zhangsan'
            }
        })

        // 修改 vm.price ，页面内容会立刻修改
        vm.price = 200
        vm.name = 'imooc'
    </script>
```

针对响应式，我们需要关心的问题是：

- 为何修改`vm.price`之后， vue 就立刻监听到
- `price`本来是`data`的属性，为何会到`vm`的属性中

其他的，例如监听修改之后如何去修改 html 内容，我们暂时不用关心，后面会讲到

## `Object.defineProperty`

对于一个简单的 JS 对象，每当获取属性、重新赋值属性的时候，都要能够监听到（至于为何有这种需求，先不要管）。以下方式是无法满足需求的

```js
var obj = {
    name: 'zhangsan',
    age: 25
}
console.log(obj.name)  // 获取属性的时候，如何监听到？
obj.age = 26           // 赋值属性的时候，如何监听到？
```

借用`Object.defineProperty`就可以实现这种需求

```js
var obj = {}
var name = 'zhangsan'
Object.defineProperty(obj, "name", {
    get: function () {
        console.log('get')
        return name  
    },
    set: function (newVal) {
        console.log('set')
        name = newVal
    }
});

console.log(obj.name)  // 可以监听到
obj.name = 'lisi'      // 可以监听到
```


针对 JS 对象可以使用`Object.defineProperty`来做监控，但是针对数组元素的改变，却用不了，例如数组的push pop等。

Vue 解决这个问题的办法也比较简单粗暴，直接将需要监听的数组的原型修改了。**注意，并不是将Array.prototype中的方法改了，那样会造成全局污染，后果严重**。看如下例子：

```js
var arr1 = [1, 2, 3]
var arr2 = [100, 200, 300]
arr1.__proto__ = {
    push: function (val) {
        console.log('push', val)
        return Array.prototype.push.call(arr1, val)
    },
    pop: function () {
        console.log('pop')
        return Array.prototype.pop.call(arr1)
    }
    // 其他原型方法暂时省略。。。。
}
// 注意，并不是将Array.prototype中的方法改了，那样会造成全局污染，后果严重

arr1.push(4)    // 可监听到
arr1.pop()      // 可监听到
arr2.push(400)  // 不受影响
arr2.pop()      // 不受影响
```

Vue 实现的时候会考虑更加全面，不会这么简单粗暴的赋值，但是基本原理都是这样的。如果读者不是特别抠细节的话，了解到这里就 OK 了。

## 模拟实现

使用`Object.defineProperty`来模拟一下 vue 的这种监听机制

```js
// var vm = new Vue({
//     el: '#app',
//     data: {
//         price: 100,
//         name: 'zhangsan'
//     }
// })

var mv = {}
var data = {
    price: 100,
    name: 'zhangsan'
}

var key, value
for (key in data) {
    // 命中闭包。新建一个函数，保证 key 的独立的作用域
    (function (key) {
        Object.defineProperty(mv, key, {
            get: function () {
                console.log('get')
                return data[key]  
            },
            set: function (newVal) {
                console.log('set')
                data[key] = newVal
            }
        })
    })(key)
}

```

## 总结

- 关键是理解`Object.defineProperty`
- 将 data 的属性代理到 vm 上

