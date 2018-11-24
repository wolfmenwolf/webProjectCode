# jquery 原型如何实现

jquery 的实现方式比 zepto 要更加绕一些，考验各位的理解能力

核心函数

```js
var jQuery = function (selector) {
    // 注意 new 关键字，第一步就找到了构造函数
    return new jQuery.fn.init(selector);
}

// 定义构造函数
var init = jQuery.fn.init = function (selector) {
    var slice = Array.prototype.slice
    var dom = slice.call(document.querySelectorAll(selector))

    var i, len = dom ? dom.length : 0
    for (i = 0; i < len; i++) this[i] = dom[i]
    this.length = len
    this.selector = selector || ''
}

// 初始化 jQuery.fn
jQuery.fn = jQuery.prototype = {
    constructor: jQuery,

    // 其他函数...
    css: function (key, value) {
    },
    html: function (value) {
    }
}
// 定义原型
init.prototype = jQuery.fn;
```
