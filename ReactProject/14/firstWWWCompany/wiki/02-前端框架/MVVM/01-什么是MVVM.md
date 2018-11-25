# 什么是 MVVM

> 要做一个 vue 的例子，照顾一下没用过 vue 的学生

## 例子

结合之前做的 vue to-do-list 的例子

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
    var data = {
        title: '',
        list: []
    }
    var vm = new Vue({
        el: '#app',
        data: data,
        methods: {
            add: function () {
                this.list.push(this.title)
                this.title = ''
            }
        }
    })
</script>
```

## 解说

MVVM 拆解开来就是 Model View ViewModel ，对设计模式多少了解一些的读者，应该知道 Model View 是什么，关键在于 ViewModel。我在最开始接触 vue 并试图理解 MVVM 的时候，是从下图开始的

![](https://user-images.githubusercontent.com/9583120/32172846-0a520f48-bd4b-11e7-9e2b-1ebdcb293387.jpeg)

View 即视图，我觉得更好的解释是“模板”，就是代码中`<div id="app">...</div>`的内容，用于显示信息以及交互事件的绑定，写过 html 的都明白。

Model 即模型（或数据），跟 MVC 中的 Model 一样，就是想要显示到模型上的数据，也是我们需要在程序生命周期中可能需要更新的数据。View 和 Model 分开，两者无需相互关心，相比于 jquery 时代，这已经是设计上的一个巨大进步。

两者分开之后得通过 ViewModel 连接起来，`el: '#app'`牵着 View ，`data: model`牵着 Model ，还有一个`methods`（其实不仅仅是`methods`，还有其他配置）充当 controller 的角色，可以修改 Model 的值。

## 带来的改变

如果用 jquery 实现上述功能，那肯定得将 click 事件绑定到 DOM 上，数据的更新会直接修改 DOM —— 总之吧，什么事儿都得操作 DOM 。这样，我们就会将 View Model Controller 完全耦合在一起，很容易搞成意大利面一样的程序。

完全分开之后，click 事件直接关联到 ViewModel 中，事件直接修改 Model ，然后由框架自动去完成 View 的更新。相比于手动操作 DOM ，你可以通过修改 Model 去控制 View 更新，这样在降低耦合的同时，也更加符合人的逻辑习惯，简直让人欲罢不能。

从 vue 以及其他 MVVM 框架，基本已经用于全球各种 web 系统的开发中，而且是很快推广普及，可见开发人员对它的认可 —— 这也是读者学习 MVVM 的必要性！