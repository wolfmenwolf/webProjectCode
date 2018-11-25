# MVVM 关键要素

> 数据（依赖绑定） 模板（模板解析） render（vdom）

## 通过一个 demo

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

## 关键要素分析

- 响应式：vue 中的 data 数据，随便一改动，视图就能随着变化——如何监听这个变化的呢？
- 模板解析：模板看似是 html 但是它不是，因为它有指令，因此它是有逻辑的、动态的，而 html 只是静态的
- 渲染：页面一加载的显示，以及 data 变化之后的显示，如何做到的？特别是 rerender ，不能变化一点数据，页面全部都重新渲染。

## 三要素之间的关系

（可以用流程图展示）

（先不要深钻细节，先看看说的有没有道理，一步一步来）

第一，解析 data ，开始监听变化
第二，解析 template ，绑定 data 变化的监听事件
第三，第一次渲染
第四，当 data 有变化，根据此前的监听关系重新渲染

