# MVVM 实现流程

vue MVVM 的实现流程比较复杂，再做一次整体流程的总结，再强调那些重点的概念。先上图

![](https://user-images.githubusercontent.com/9583120/31386983-622b714a-ad8e-11e7-97c7-02204e7a388f.png)


## 关键要素

- 响应式，数据变化的监听
- 模板解析
- 渲染过程

## 响应式

创建 Observer 对象，然后针对 data 中的每个属性 defineProperty 定义 get 和 set 。get 中准备收集异类，set 中准备出发依赖的通知。

```js
Object.defineProperty(obj, key, {
    get: function reactiveGetter () {
        if (Dep.target) { // 暂存依赖对象（Watcher 实例）
          dep.depend()  // 绑定依赖
        }
        return val
    },
    set: function reactiveSetter (newVal) {
        val = newVal
        dep.notify()  // 触发依赖，最终会异步 rerender
    }
})
```

最后会创建`vm._watcher = new Watcher(vm, updateComponent, noop)`，Watcher 中在初始化的时候会设置依赖`pushTarget(this)`，并且执行`updateComponent`会获取属性（即触发 get ），将这个依赖绑定上。

数据被修改，会触发 set 然后出发`dep.notify()`，然后出发`_watcher`中的`update`，最终异步执行`run()`

```js
import Dep, { pushTarget, popTarget } from './dep'

export default class Watcher {
  constructor (
    vm: Component,
    expOrFn: string | Function,
    cb: Function
  ) {
    // 传入的函数，赋值给 this.geter
    this.getter = expOrFn
    // 执行 get() 方法
    this.value = this.get()
  }

  get () {
    // 将 this （即 Wathcer 示例）给全局的 Dep.target
    pushTarget(this)
    let value
    const vm = this.vm
    try {
      // this.getter 即 new Watcher(...) 传入的第二个参数 expOrFn
      // 这一步，即顺便执行了 expOrFn
      value = this.getter.call(vm, vm)
    } catch (e) {
      // ...
    } finally {
      popTarget()
    }
    return value
  }

  // dep.subs[i].notify() 会执行到这里
  update () {
    // 异步处理 Watcher
    // queueWatcher 异步调用了 run() 方法，因为：如果一次性更新多个属性，无需每个都 update 一遍，异步就解决了这个问题
    queueWatcher(this)
  }

  run () {
    // 执行 get ，即执行 this.getter.call(vm, vm) ，即执行 expOrFn
    this.get()
  }
}
```

## 模板解析

首先要了解两个要点：第一，模板是一个字符串，非结构化的，需要转换成结构化的 AST ；第二，模板中的变量和指令需要通过执行 JS 代码来实现，因此需要最后转换为 render 函数，执行函数返回的是 vdom 。

首先，将模板转换为 AST 这种结构化的形式，并且解析其中的指令为表达式形式。其中用到了 htmlparser 这个工具。

最后，将 AST 转换为 render 函数。先变为函数体，然后通过`new Function(...)`生成真正的函数。

## 渲染

通过 vdom 进行渲染。如果抛开 vdom 的实现细节，其实这个渲染过程是一个黑盒，我们只需要执行`updateComponent`即可完成渲染。

```js
let updateComponent = () => {
  vm._update(vm._render())
}

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

分为两种情况。第一，初次渲染会直接全部渲染到 $el ；第二，rerender 时进行 diff 算法计算出差异，然后按需渲染。

## 三个概念

有三个概念可能会有模糊，再重新梳理一下：（重点：这三者是一种设计上的拆分，让每个角色都做独立的事情，不相互干扰，介绍耦合）

- Observer —— 最先执行的，遍历 data 属性，执行 defineProperty ，然后在 set 中**准备**收集依赖`dep.depend()`，set
 中**准备**触发依赖`dep.notify()`。注意，这里是“准备”，并没有直接出发，因此此时 set 和 get 都没有被触发过。
- Dep —— 是一个收集容器，被动的。可以调用`dep.depend()`追加很多依赖，可以调用`notify`去触发这些相关的依赖。至于触发依赖能做啥，它不管，只管着触发就好了。
- Watcher —— 是一个真正的观察者，定义了触发通知之后的真正实现逻辑。

## 最后

在看这张图

![](https://user-images.githubusercontent.com/9583120/31386983-622b714a-ad8e-11e7-97c7-02204e7a388f.png)

