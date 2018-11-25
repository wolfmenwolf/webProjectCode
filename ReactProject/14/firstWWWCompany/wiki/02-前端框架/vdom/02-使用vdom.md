# 使用 vdom

所谓的 vdom 就是用 JS 对象去模拟一个真实的 DOM 结构。所有的 html 标签（或者 DOM 节点），都可以用以下 JS 结构来表示（这也是 xml 的特点决定的）

```js
{
    tag: 'div',
    attrs: {
        id: 'container'
    },
    children: []
}
```

例如

```html
<ul id='list'>
  <li class='item'>Item 1</li>
  <li class='item'>Item 2</li>
</ul>
```

就可以用以下方式来表示

```js
{
    tag: 'ul',
    attrs: { id: 'list' },
    children: [
        {
            tag: 'li',
            attrs: { className: 'item' },
            children: ['Item 1']
        }, {
            tag: 'li',
            attrs: { className: 'item' },
            children: ['Item 2']
        }
    ]
}
```

**介绍`vdom`和`vnode`的区别**

## 基本流程

先说一下使用 vdom 的基本流程，结合上一节使用 jquery 的 demo 。

- 使用 data 生成一个 vnode （vnode 和 vdom 的区别，就跟 node 和 dom 的区别一样）
- 第一次渲染时，直接将这个 vnode 渲染到`#container`中，并将这份 vnode 暂存下来
- 当 change 的时候，在根据 change 之后的 data 重新生成一份 newVnode
- 那 newVnode 和之前存储的 vnode 做对比，将有差异的部分渲染到页面中（无差异的部分，不动）。这一步一般都是 vdom 工具封装好的，我们只需调用即可。

## snabbdom

snabbdom 是一个开源的 vdom 库（github 可以搜到），vue 中的 vdom 操作就引用了它。先介绍一下它的几个核心函数

`h`函数，第一个参数是 html 标签（也支持 css 选择器，这属于锦上添花），第二个参数是属性，第三个参数是子元素（一个数组）

```js
var vnode = h('div#container.two.classes', {on: {click: someFn}}, [
  h('span', {style: {fontWeight: 'bold'}}, 'This is bold'),
  ' and this is just normal text',
  h('a', {props: {href: '/foo'}}, 'I\'ll take you places!')
]);
```

`path`函数，第一个参数是一个 DOM 节点或者 vnode ，第二个参数是 vnode

```js
var container = document.getElementById('container');

// Patch into empty DOM element – this modifies the DOM as a side effect
patch(container, vnode);

// Second `patch` invocation
patch(vnode, newVnode); // Snabbdom efficiently updates the old view to the new state
```

**对于外部 snabbdom（或者其他 vdom 库） 的使用者来说，核心函数就是`h`和`vdom`**

## h 函数

```js
var vnode = h('ul#list', {}, [
    h('li.item', {}, 'Item 1'),
    h('li.item', {}, 'Item 2')
])
```

## patch 函数

```js
var vnode = h('ul#list', {}, [
    h('li.item', {}, 'Item 1'),
    h('li.item', {}, 'Item 2')
])

var container = document.getElementById('container')
patch(container, vnode)

// 模拟改变
var btnChange = document.getElementById('btn-change')
btnChange.addEventListener('click', function () {
    var newVnode = h('ul#list', {}, [
        h('li.item', {}, 'Item 111'),
        h('li.item', {}, 'Item 222'),
        h('li.item', {}, 'Item 333'),
    ])
    patch(vnode, newVnode)
})
```

## 重做 demo

按照之前总结的步骤，重写 demo 代码如下

```html
<div id="container"></div>
<button id="btn-change">change</button>

<script src="https://cdn.bootcss.com/snabbdom/0.7.0/snabbdom.js"></script>
<script src="https://cdn.bootcss.com/snabbdom/0.7.0/snabbdom-class.js"></script>
<script src="https://cdn.bootcss.com/snabbdom/0.7.0/snabbdom-props.js"></script>
<script src="https://cdn.bootcss.com/snabbdom/0.7.0/snabbdom-style.js"></script>
<script src="https://cdn.bootcss.com/snabbdom/0.7.0/snabbdom-eventlisteners.js"></script>
<script src="https://cdn.bootcss.com/snabbdom/0.7.0/h.js"></script>
<script type="text/javascript">
    var snabbdom = window.snabbdom
    // 定义关键函数 patch
    var path = snabbdom.init([
        snabbdom_class,
        snabbdom_props,
        snabbdom_style,
        snabbdom_eventlisteners
    ])

    // 定义关键函数 h
    var h = snabbdom.h

    // 原始数据
    var data = [
        {
            name: '张三',
            age: '20',
            address: '北京'
        },
        {
            name: '李四',
            age: '21',
            address: '上海'
        },
        {
            name: '王五',
            age: '22',
            address: '广州'
        }
    ]
    // 把表头也放在 data 中
    data.unshift({
        name: '姓名',
        age: '年龄',
        address: '地址'
    })

    var container = document.getElementById('container')

    // 渲染函数
    var vnode
    function render(data) {
        var newVnode = h('table', {}, data.map(function (item) {
            // 获取所有的 td
            var tds = []
            var i
            for (i in item) {
                if (item.hasOwnProperty(i)) {
                    tds.push(h('td', {}, [item[i] + '']))
                }
            }
            // 返回 tr
            return h('tr', {}, tds)
        }))
        if (vnode) {
            path(vnode, newVnode)
        } else {
            path(container, newVnode)
        }
        // 保存当前的 vnode
        vnode = newVnode
    }

    // 修改信息
    document.getElementById('btn-change').addEventListener('click', function () {
        data[1].age = 30
        data[2].address = '深圳'

        // re-render
        render(data)
    })

    // 第一次渲染
    render(data)

</script>
```

## 对比

运行 jquery 的 demo ，然后用 chrome 查看 DOM 结构，点击“change”按钮看看都有哪些节点有变化。同样的逻辑，再用 snabbdom 的 demo 运行起来，然后用 chrome 查看 DOM 结构，点击“change”按钮看看都有哪些节点有变化。—— 很容易就能看出两者的区别。

