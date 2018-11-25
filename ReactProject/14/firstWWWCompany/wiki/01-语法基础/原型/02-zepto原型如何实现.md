# zepto 原型如何实现

## 找到 zepto 对象是哪里创建的

```js
  // 空对象
  var zepto = {}

  // 这就是构造函数
  function Z(dom, selector) {
    var i, len = dom ? dom.length : 0
    for (i = 0; i < len; i++) this[i] = dom[i]
    this.length = len
    this.selector = selector || ''
  }

  zepto.Z = function(dom, selector) {
    // 注意，出现了 new 关键字
    return new Z(dom, selector)
  }

  zepto.init = function (selector) {
    // 源码中，这了的处理情况比较复杂。但因为本次只是针对原型，因此这里就弱化了
    var slice = Array.prototype.slice
    var dom = slice.call(document.querySelectorAll(selector))
    return zepto.Z(dom, selector) 
  }

  // 即使用 zepto 时候的 $
  var $ = function(selector){
    return zepto.init(selector)
  }
```

## 找到原型

```js
$.fn = {
    constructor: zepto.Z,

    css: function (key, value) {

    },
    html: function (value) {

    }
}

zepto.Z.prototype = Z.prototype = $.fn
```

构造函数`Z`的原型的方法，是在`$.fn`定义完了之后，又赋值给`Z.prototype`的

另外，`constructor`赋值了`zepto.Z`而不是`Z`，这是我不太理解的地方，不过完全不影响使用

## 最后

以上提到的每一个核心函数，都要完全透彻的理解才行。
