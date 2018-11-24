# MVVM 渲染

上面讲到模板最终生成 render 函数，render 函数执行，最终返回的是 vdom（vdom 的细节后面会讲到）

## updateComponent

```js
let updateComponent = () => {
  vm._update(vm._render())
}
```

每次执行`vm._update`的时候，都会重新执行 render 函数，并且将返回结果（即 vdom ）传递给`vm._update`

```js
Vue.prototype._update = function (vnode) {
  const prevVnode = vm._vnode
  vm._vnode = vnode
  // Vue.prototype.__patch__ is injected in entry points
  // based on the rendering backend used.
  if (!prevVnode) {
    // initial render
    vm.$el = vm.__patch__(vm.$el, vnode)
  } else {
    // updates
    vm.$el = vm.__patch__(prevVnode, vnode)
  }
}
```

`vm._update`中，如果是页面初次渲染，直接全部渲染到`$el`中，即我们选中的 DOM 节点。如果是 rerender ，那么会进行 diff 算法的对比，然后按需渲染。这些都是通过`__patch__`方法实现的。

（简单介绍一下 diff 算法）

`__patch__`是 vdom 计算的核心，后面会专门通过一个章节讲解其中的原理，这里先知道他怎么用。


## Watcher

`updateComponent`从哪里被触发呢？

`vm._watcher = new Watcher(vm, updateComponent, noop)` 这里创建一个 Wacher 示例，把`updateComponent`传递近期，然后看下 Watcher 的实现

```js
vm._watcher = new Watcher(vm, updateComponent, noop)
```

```js
import Dep, { pushTarget, popTarget } from './dep'

export default class Watcher {
  constructor ( vm, expOrFn, cb) {
    this.getter = expOrFn // 传入的函数，赋值给 this.geter
    this.value = this.get() // 执行 get() 方法
  }
  get () {
    pushTarget(this) // 将 this （即 Wathcer 示例）给全局的 Dep.target
    const vm = this.vm
    let value = this.getter.call(vm, vm)
    popTarget()  // 添加完依赖之后，踢出
    return value
  }
  // dep.subs[i].notify() 会执行到这里
  update () {
    // queueWatcher 异步调用了 run() 方法，因为：如果一次性更新多个属性，无需每个都 update 一遍，异步就解决了这个问题
    queueWatcher(this)
  }
  run () {
    this.get()  // 执行 get ，即执行 this.getter.call(vm, vm) ，即执行 expOrFn
  }
}
```

简单介绍一下源码，然后注意几点：

- 初始化时（即页面第一次渲染），执行了`this.get()`，其中做了两件事。
    - `pushTarget(this)`将依赖暴露出来，这个“依赖”是什么 —— `this`；
    - `value = this.getter.call(vm, vm)`执行了`updateComponent`（执行时会触发 defineProperty 中的`get`，绑定依赖，结合以下代码看）；
    - `popTarget()`又把依赖去掉
- 当 data 中的数据有变化时，肯定会触发 defineProperty 中的`set`，就会触发`dep.notify()`。这里就会最终走到上面的`update`方法中。`update`是一个异步队列（vue 的渲染是异步执行的，React 也是），最终会执行`run`方法，重新执行`this.get`，即重新执行了`updateComponent`。这就完成了 rerender

```js
// “MVVM 响应式” 介绍过的代码
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
```

## dep

至于 Dep 的代码无需深究，只需要知道以下

- `Dep.target`，依赖对象（Watcher 示例）临时保存的地方
- `dep.depend()`，添加依赖
- `dep.notify()`，触发通知


## 异步渲染

最后聊一下异步渲染。

如果你一次性执行了很多 data 数据的修改，那么 vue 会不会同时执行这么多次的 rerender ？—— 肯定不会！没有必要，而且浪费性能。通过 JS 异步的特性即可轻松实现这种逻辑。

举一个最简答的例子

```js
var queue = []
setTimeout(function () {
    queue.forEach(item => {item()})
})
for (let i = 0; i < 10; i++){
    queue.push(function () {console.log(i)})
}
```

