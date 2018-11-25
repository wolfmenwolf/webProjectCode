# MVVM 实现流程

## 目录

- 针对一个 demo
- 第一步：解析模板成 render 函数
- 第二步：响应式开始监听
- 第三步：首次渲染，显示页面，且绑定依赖
- 第四步：data 属性变化

## 针对一个 demo

拿一个简单的例子

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
<script type="text/javascript" src="./vue-2.5.1.js"></script>
<script type="text/javascript">
    var vm = new Vue({
        el: '#app',
        data: {
            title: '',
            list: []
        },
        methods: {
            add: function () {
                this.list.push(this.title)
                this.title = ''
            }
        }
    })
</script>
```

## 第一步：解析模板成 render 函数

拿到模板

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

解析成 render 函数（vue 2.0 开始支持预编译，即在开发环境编译时，有工具已经将模板编译为 render 函数）

```js
// 未格式化的 render 函数
with(this){return _c('div',{attrs:{"id":"app"}},[_c('div',[_c('input',{directives:[{name:"model",rawName:"v-model",value:(title),expression:"title"}],domProps:{"value":(title)},on:{"input":function($event){if($event.target.composing)return;title=$event.target.value}}}),_v(" "),_c('button',{on:{"click":add}},[_v("submit")])]),_v(" "),_c('ul',_l((list),function(item){return _c('li',[_v(_s(item))])}))])}
```

对于 render 函数需要注意的是：

- `with`的用法
- 模板中的所有信息都被 render 函数包含
- 模板中用到的 data 中的属性，都变成了 JS 变量
- 模板中的`v-model` `v-for` `v-on`都变成了 JS 逻辑
- render 函数最终返回的是 vnode

## 第二步：响应式开始监听

使用`Object.defineProperty`监听`data`中参数，并且代理到`vm`上

```js
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

## 第三步：首次渲染，显示页面，且绑定依赖

再首次渲染之前就定义了`updateComponent`函数

```js
vm._update(vnode) {
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
function updateComponent() {
  // vm._render 即 上面的 render 函数，返回 vnode
  vm._update(vm._render())
}
```

页面首次加载，即首次渲染时，会执行`updateComponent`，即执行了`vm._render()`。执行 render 函数时，会访问到`vm.list` `vm.title`等 data 中的属性值。

而这些属性，都是做过响应式监听的，访问他们的值会立刻出发到`get`

```js
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
```

**为何要监听`get`呢？** —— 即，data 中有很多属性，有些是有用的（会体现为 render 函数中的变量），有些可能没啥用。监听`get`是为了保证只有有用的属性才才去监听它的`set`，如果这个属性没用过，那么它的`set`我们也就不管了。

（图示：之前 ppt 的一个图）

## 第四步：data 属性变化

修改 data 的属性值

```js
var vm = new Vue({
    el: '#app',
    data: {
        title: '',
        list: []
    },
    methods: {
        add: function () {
            this.list.push(this.title)  // 修改属性值
            this.title = ''             // 修改属性值
        }
    }
})
```

修改属性值，会立刻被响应式的`set`监听到，会再次出发`updateComponent`函数，即执行`vm.__patch__(prevVnode, vnode)`，借用 vdom 完成更新。

## 总结

- 第一步：解析模板成 render 函数
- 第二步：响应式开始监听
- 第三步：首次渲染，显示页面，且绑定依赖
- 第四步：data 属性变化
