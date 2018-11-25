# 从 jQuery 到框架

一个 to-do-list 的 demo ，分别用 jquery vue 和 React 实现 。也照顾一下对 vue react 不熟悉的同学。

## jquery 实现 to-do-list

```html
<div>
    <input type="text" name="" id="txt-title">
    <button id="btn-submit">submit</button>
</div>
<div>
    <ul id="ul-list"></ul>
</div>

<script type="text/javascript" src="./jquery-3.2.1.js"></script>
<script type="text/javascript">
    var $txtTitle = $('#txt-title')
    var $ulList = $('#ul-list')
    var $btnSubmit = $('#btn-submit')
    $btnSubmit.click(function () {
        var title = $txtTitle.val()
        var $li = $('<li>' + title + '</li>')
        $ulList.append($li)
        $txtTitle.val('')
    })
</script>
```

jquery 的特点——简单粗暴——想改哪里，就动哪里的 DOM，每一步都伴随着 DOM 操作。因此，学习前端知识，一开始最好要先从 jquery 做起。

## vue 实现 to-do-list

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

演示了 MVVM ，定义好模板，修改数据即可，即数据驱动视图

## react 实现 to-do-list

使用工具 https://github.com/facebookincubator/create-react-app 安装环境 ，初始化一个 react 开发环境，然后将入口文件 app.js 清理一下，先暂时只显示`hello world`

按照已经写好的代码讲解：

- 创建`components`目录，再创建`todo`目录
- 其中再创建`index.js`和`input` `list`目录
- ……

重点讲解出：第一，什么是组件；第二，组件是一个独立的孤岛（数据独立）；第三，数据之间如何联动（数据传递）

