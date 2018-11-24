# jquery 看源码

一开始，是一个 umd 规范的封装。封装之后，后面函数的返回值，会直接挂在到 window 对象。

然后看代码一开始定义了`jQuery`，最后`return jQuery;`

然后就是上一节将的核心代码