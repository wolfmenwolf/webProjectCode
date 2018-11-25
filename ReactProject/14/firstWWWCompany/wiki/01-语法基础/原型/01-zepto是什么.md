# zepto 是什么

先来看看 zepto 是什么。别以为他很基础，平时用 zepto 很多的，并不一定能注意到这些问题，还是跟我一起看看。

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
        var $p = $('p')
        $p.css('color', 'red')  // css 是原型方法
        console.log($p.html())  // html 是原型方法

        var $div1 = $('#div1')
        $div1.css('color', 'blue')  // css 是原型方法
        console.log($div1.html())  // html 是原型方法
    </script>
```
