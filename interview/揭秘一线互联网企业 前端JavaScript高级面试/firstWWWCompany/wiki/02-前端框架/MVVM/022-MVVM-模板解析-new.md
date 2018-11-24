# MVVM 模板解析

## 目录

- 模板是什么？
- render 函数
- render 函数与 vdom 的关系

扩展知识：如何生成 render 函数（扩展知识后面再看情况补充视频）

- 结构化与非结构化
- 生成 AST
- 生成函数体字符串

## 模板是什么？

```html
<div id="app">
    <div>
        <input v-model="title">
        <button v-on:click="add">submit</button>
    </div>
    <ul>
        <li v-for="item in list">{{item}}</li>
    </ul>
</div>
```

它看似像 html ，但是它不是，html 解析不了它，因为有指令。首先，html 根本无法识别指令；其次，最重要的，指令是动态的、逻辑的（`v-if` `v-for`等），而 html 是纯静态的。

因此，模板和 html 根本就是两码事，就像雷锋和雷峰塔的关系 —— 长的像一点而已。

那么模板是什么？—— 对于 vue 来说，模板就是一坨字符串，就这么简单。

- 字符串，是非结构化的
- 有逻辑，如`v-for` `v-if`等指令，是动态的

和 html 对比

- 标签类型相同
- html 是静态，模板是有逻辑的动态的

要想实现模板的这些“功能”，就必须将模板转换为 JS 代码，否则无法实现（仔细想想是否是这个道理）

- 模板中有指令，是动态的、有逻辑的，必须转换成 JS 代码才能运行 —— 上文讲过
- 模板最终要生成 html （模板不是 html）渲染页面，也只有 JS 能渲染 html 。因此，整个模板都要转换成 JS 代码才行，不光是指令。

## render 函数

> 模板如何转换为 render 函数，这个其实我们不用关心，因为 vue 2.0 开始已经支持开发环境的编译工具转换。下面会在扩展知识中讲解转换的过程，作为扩展的了解。

一开始先介绍一下 JS 中`with`如何应用，平常不常见。**而且，日常开发也严重不推荐使用！！！**

```js
var obj = {
    name: 'zhangsan',
    age: 20,
    getAddress: function () {
        alert('beijing')
    }
}

// 不用 with
function fn() {
    alert(obj.name)
    alert(obj.age)
    obj.getAddress()
}
fn()

// 使用 width
function fn1() {
    with(obj) {
        alert(name)
        alert(name)
        getAddress()
    }
}
fn1()
```

先看一下两个示例中的模板和 render 函数是什么样子的

```html
<div id="app">
    <p>{{price}}</p>
</div>

<script src="./vue-2.5.9.js"></script>
<script>
    var vm = new Vue({
        el: '#app',
        data: {
            price: 100
        }
    })
</script>
```

示例一

```html
<div id="app">
    <p>{{price}}</p>
</div>
```

```js
with(this){
    return _c(
        'div',
        {
            attrs:{"id":"app"}
        },
        [
            _c('p',[_v(_s(price))])
        ]
    )
}
```

- 这里的 this 就是 vm ，因此 price 也就是 vm.price
- _c ，即 vm._c ，是 vue 早就定义好的函数，下文会具体讲

总之，通过这个函数，我们看到了:

- 模板中的所有信息，都已经被收集到函数中
- 模板中的 price ，也已经变成了 vm.price

示例二（**直接在编辑器中看吧，太多了**）

```html
<div id="app">
    <div>
        <input v-model="title">
        <button v-on:click="add">submit</button>
    </div>
    <ul>
        <li v-for="item in list">{{item}}</li>
    </ul>
</div>
```

```js
with(this){
    return _c(
        'div',
        {
            attrs:{"id":"app"}
        },
        [
            _c(
                'div',
                [
                    _c(
                        'input',
                        {
                            directives:[
                                {
                                    name:"model",
                                    rawName:"v-model",
                                    value:(title),
                                    expression:"title"
                                }
                            ],
                            domProps:{
                                "value":(title)
                            },
                            on:{
                                "input":function($event){if($event.target.composing)return;title=$event.target.value}
                            }
                        }
                    ),
                    _v(" "),
                    _c(
                        'button',
                        {
                            on:{
                                "click":add
                            }
                        },
                        [
                            _v("submit")
                        ]
                    )
                ]
            ),
            _v(" "),
            _c(
                'ul',
                _l((list),function(item){return _c('li',[_v(_s(item))])})
            )
        ]
    )
}
```

以上 render 函数很大（但这个 demo 不复杂，可想而知一个项目中的 render 函数是怎样的），应该关心的点有：

- 模板中的信息是否都已经包含在 render 函数中了
- `v-model`是怎么实现的
- `v-on:click`是怎么实现的
- `v-for`是怎么实现的

## render 函数与 vdom 的关系

（**有必要先把之前 vdom 的核心内容再复习一遍**）

这是刚刚的 render 函数

```js
// 上文的 render 函数
with(this){
    return _c(
        'div',
        { attrs: {"id":"app"} },
        [ _c('p',[_v(_s(price))])]
    )
}

// 这是学习 snabbdom 时候的`h`函数的写法
var vnode = h('div#container.two.classes', {on: {click: someFn}}, [
  h('span', {style: {fontWeight: 'bold'}}, 'This is bold'),
  ' and this is just normal text',
  h('a', {props: {href: '/foo'}}, 'I\'ll take you places!')
]);
```

这俩其实就是一回儿事儿，vue 的 render 函数返回的就是`h`函数返回的 —— vnode 节点。 render 函数中的`_c`（即`vm._c`）其实就是 vue 封装的生成 vnode 的函数，跟`h`函数一样。

vue 中有一个`updateComponent`方法是这么定义的

```js
vm._update(vnode) {
  const prevVnode = vm._vnode
  vm._vnode = vnode
  if (!prevVnode) {
    vm.$el = vm.__patch__(vm.$el, vnode)
  } else {
    vm.$el = vm.__patch__(prevVnode, vnode)
  }
}
function updateComponent() {
  // vm._render 即 上面的 render 函数，返回 vnode
  vm._update(vm._render())
}
```

看到这里，就能明白 vue 是如何使用 render 函数的了

- `vm._render()`执行返回 vnode ，传给`_update`
- `_update`中会判断是否有`prevVnode`，然后分情况执行`vm.__patch__`
- `vm.__patch__`就是之前讲解 vdom 的`patch`

第一，页面初次渲染的时候，执行`updateComponent`，将 vnode 直接 patch 到 $el。第二，当 data 属性改变的时候，监听变化，也执行`updateComponent`，对 prevVnode, vnode 进行 patch 。

## 总结

- 模板的本质：一堆字符串，带有逻辑功能
- 需要转换成 JS 代码（逻辑，渲染 html）
- 模板渲染成 render 函数的格式
- render 函数返回的是 vnode
- updateComponent

-------

（扩展知识后面再看情况补充视频）

## 如何生成 render 函数

vue 2.0 已经支持预编译 —— 即你在开发环境写的是类似 html 的模板，当时经过开发环境编译之后，就已经将模板转换为 render 函数了


## 结构化与非结构化


## 生成 AST


## 生成函数体字符串
