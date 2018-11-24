# jquery 是什么

这一节完全可以照搬“zepto 是什么”那一节的内容，因为两者的基础 API 都是一样的

## demo

先做一个简单的 demo 页面，就平时最基本的使用方式

```html
    <p>jquery test 1</p>
    <p>jquery test 2</p>
    <p>jquery test 3</p>

    <div id="div1">
        <p>jquery test in div</p>
    </div>

    <script type="text/javascript" src="./jquery-3.2.1.js"></script>
    <script type="text/javascript">
        console.log($)

        var $p = $('p')
        console.log($p)

        var $div1 = $('#div1')
        console.log($div1)
    </script>
```

这里打印出来的俩对象，是什么数据结构呢？—— 类数组，解释一下什么是类数组

还有`console.log($)`别忘了，`$`是一个函数（从`$('p')`就能看出来），传入 selector 返回一个 zepto 对象。

## 关于原型

`$('p')`返回的`$p`的构造函数是什么？因为`$p.__proto__`等于构造函数的`prototype`

这个构造函数和`$`函数的关系是什么？