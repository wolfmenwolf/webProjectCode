# 为何使用 vdom

使用 vdom 也是基于一个现状：数据和视图的分离，即数据驱动视图。

## 需求

有这样一段数据，要显示成一个表格

```js
// 1. 将该数据展示成一个表格。2. 随便修改一个信息，表格也跟着修改
[
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
```

在页面中再增加一个按钮，点击按钮的时候可能会修改以上数据的某个信息，修改之后，表格要随着显示出修改结果。

## jquery 如何实现

如果不用 vdom ，用 jquery 实现。核心的实现逻辑如下

```html
<div id="container"></div>
<button id="btn-change">change</button>

<script type="text/javascript" src="./jquery-3.2.1.js"></script>
<script type="text/javascript">
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

    // 渲染函数
    function render(data) {
        var $container = $('#container')

        // 清空现有内容
        $container.html('')

        // 拼接 table
        var $table = $('<table>')
        $table.append($('<tr><td>name</td><td>age</td><td>address</td></tr>'))
        data.forEach(function (item) {
            $table.append($('<tr><td>' + item.name + '</td><td>' + item.age + '</td><td>' + item.address + '</td></tr>'))
        })

        // 渲染到页面
        $container.append($table)
    }


    // 修改信息
    $('#btn-change').click(function () {
        data[1].age = 30
        data[2].address = '深圳'
        render(data)
    })

    // 初始化时候渲染
    render(data)

</script>
```

## 以上实现方式的问题

从以上的实现方式看不出啥问题，但是如果这个表格很大，或者数据、视图再更加复杂，change 的频率再高一些，性能问题可能就会指数级的暴露出来。原因就是：无论修改什么数据，这个表格都会**全部渲染，而不是按需渲染**。

DOM 操作是“昂贵”的（而 JS 执行是很快的），这个大家都知道，按需渲染才能最大范围的减少数据改变对于视图的影响。改一点就重新渲染一点，不改就不重新渲染。

（打印一个 DOM 节点的属性有哪些）

那如何做到按需渲染？—— vdom 就可以做到。
