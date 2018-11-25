# MVVM 响应式

## 观察者模式

补充观察者模式的知识介绍

```js
var foo = function( value ){
    console.log( 'foo:' + value );
}
var bar = function( value ){
    console.log( 'bar:' + value );
}

var callbacks = $.Callbacks();
callbacks.add( foo );
callbacks.fire( 'hello' );  
// outputs: 'foo: hello'

callbacks.add( bar );
callbacks.fire( 'world' );  
// outputs:
// 'foo: world'
// 'bar: world'
```

## 监听对象属性变化

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

> `Object.defineProperty`是 ES5 中新增的一个 API 目前（2017.12）看来，浏览器兼容性已经不是问题，特别是针对移动端。

## 监听数组变化

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

## 使用以上技术监听 data

例如初始化时候 data 是这样的

```js
// 使用 vue
var vm = new Vue({
    el: '#div1',
    data: {                 // 对 data 中的所有属性
        price: 100,         // 是用 DefineProperty 重新绑定
        name: 'zhangsan'    // 监听到 get 和 set
    }
})

// vue 源码中
data.__ob__ = new Observer(data)
```

然后针对 data 执行 `data.__ob__ = new Observer(data)` ，`Observer`定义如下

```js
export class Observer {
  value: any;

  constructor (value: any) {
    this.value = value
    this.walk(value)
  }

  walk (obj: Object) {
    const keys = Object.keys(obj)
    for (let i = 0; i < keys.length; i++) {
      defineReactive(obj, keys[i], obj[keys[i]])
    }
  }
}
```

接下来是`defineReactive`

```js
export function defineReactive ( obj, key, val) {
    // 每次执行 defineReactive 都会创建一个 dep ，它会一直存在于闭包中
    const dep = new Dep()

    Object.defineProperty(obj, key, {
        get: function reactiveGetter () {
            if (Dep.target) {
              dep.depend()
            }
            return val
        },
        set: function reactiveSetter (newVal) {
            val = newVal
            dep.notify()
        }
    })
}
```

这个`dep`先不要关注细节，但要知道几个要点：

- `dep.depend()`是绑定依赖，要绑定进来的依赖就放在`Dep.target`中（就是后面要介绍的`Watcher`实例）
- `dep.notify()`就是触发已经绑定的依赖

## 为何要在要在 get 时候绑定依赖

在`set`时候触发依赖应该比较好理解，但是为何要在`get`时候绑定依赖呢？举一个例子就能明白

```html
<div id="app">
    <p>{{price}} 元</p>
</div>
```

```js
var vm = new Vue({
    data: {
        price: 100,
        name: 'zhangsan'
    }
})
```

对于以上的 data ，我们只在模板中引用了`price`，而完全没有用到`name`。引用一个数据会走`get`，而修改一个数据会走到`set`。

那么，当我们修改`price`时候希望视图能跟随变化，当我们修改`name`的时候呢？
