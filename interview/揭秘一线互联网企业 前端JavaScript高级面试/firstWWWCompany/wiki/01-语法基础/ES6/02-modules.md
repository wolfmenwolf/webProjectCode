# ES6 Modules

在《前端 JS 面试技巧》教程中，详细介绍过 AMD 和 CommonJS 的模块化的规范，下面介绍 ES6 中的模块化规范。相比于前两个，ES6 中的模块化规范更加简洁易懂，基本一看就会。

首先，本节要求学习者对 JS 模块化有一个基本的了解，知道什么是模块化，为何需要模块化。这些在《前端 JS 面试技巧》中讲解的比较详细，本教程作为高级教程，就不在这些基础知识上花费太多精力。

## 语法

定义一个`util1.js`，它只返回一个对象

```js
export default {
    a: 100
}
```

定义一个`util2.js`，它返回多个对象

```js
export function fn1() {
    alert('fn1')
}
export function fn2() {
    alert('fn2')
}

// fn3 并未被外部引用
export function fn3() {
    alert('fn3')
}
```

index.js

```js
import util1 from './util1.js'
import { fn1, fn2 } from './util2.js'

console.log(util1)
fn1()
fn2()
```

运行`npm start`

新建`index.html`，起一个 http-server 来看运行效果

## 关于 js 众多的模块标准

当初 JS 还没有模块化这一说，需要什么 JS 就引入什么 JS 文件。

后来，前端有人琢磨出 require.js 这一套，慢慢形成了一个 AMD 的标准。期间淘宝大神自造轮子，搞了一个 CMD（sea.js），不过现在还是 AMD 为主。（貌似每个有技术实力的公司，都会自造轮子）

nodejs 发展出来之后，前端开始有了各种自动化构建工具，因此可以将后端的模块化方案，经过打包应用到前端

ES6 出来之后，视图通过重新定义一种模块化的机制来统一这种不稳定的形式。但是目前 nodejs 支持积极，浏览器因为是客户端的原因，尚未良好支持。—— 期待早日统一

还有些工具、框架自造模块化标准，另起炉灶。我的观点：你可以自造模块化 lib ，但是你不要自造标准。

## rollup

注意看，util2.js 中定义的`fn3`并没有被外部引用，也打包进去了。另外，webpack 打包出来文件有一些其他的代码，很复杂。

给大家安利一个非常好用的 JS 模块化打包工具 [rollup.js](http://rollupjs.org/)。React Vue 都用它打包的，我自己的开源项目 [wangEditor](http://www.wangeditor.com/) 也是用它打包的。
