# zepto 看源码

一开始，是一个 umd 规范的封装

接下来 

```js
var Zepto = (function () {
    var $ = function () {

    }

    // 返回核心函数
    return $
})

// 暴露全局方法
window.Zepto = Zepto
window.$ === undefined && (window.$ = Zepto)

// 一些扩展，https://github.com/madrobby/zepto#zepto-modules 这些模块都是通过这种方式扩展的
;(function($) {

})(Zepto)

;(function($) {

})(Zepto)

;(function($) {

})(Zepto)
```

然后就是上一节讲的那些核心方法