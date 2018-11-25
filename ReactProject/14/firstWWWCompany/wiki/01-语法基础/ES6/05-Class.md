# Class

目前使用 class 的场景非常多，例如在使用 React 时

```jsx
class Ad extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            data: []
        }
    }
    render() {
        return (
            <div>hello imooc</div>
        )
    }
    componentDidMount() {
        
    }
}
```

## 基本用法

JS 代码

```js
function MathHandle(x, y) {
  this.x = x;
  this.y = y;
}

MathHandle.prototype.add = function () {
  return this.x + this.y;
};

var m = new MathHandle(1, 2);
console.log(m.add())
```

ES6 代码

```js
class MathHandle {
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }

  add() {
    return this.x + this.y;
  }
}
const m = new MathHandle(1, 2);
console.log(m.add())
```

`npm start`看一下，可以看到编译出来的代码有许多附加的内容，不在简洁

其实 class 就是 js 构造函数的一个语法糖，连原型链原理都是一样的（**这种语法糖形式，看起来和实际原理不一样的东西，我个人不太赞同**）

```js
class MathHandle {
  // ...
}

typeof MathHandle // "function"
MathHandle === MathHandle.prototype.constructor // true

// 这种语法糖形式，看起来和实际原理不一样的东西，我个人不太赞同
// 形式上强行模仿 java C# ，却失去了它的本性和个性
```

另外，使用 class 打包出来的 JS 代码，会有很多冗余附加代码，**这就导致使用发布的代码调试 bug 的时候变得很困难**。

## 继承

使用 JS 的原型如何实现集成，在《前端 JS 面试技巧》的课程中已经详细讲过。这里再拿一个例子简单回顾一下，

```js
// 动物
function Animal() {
    this.eat = function () {
        console.log('animal eat')
    }
}
// 狗
function Dog() {
    this.bark = function () {
        console.log('dog bark')
    }
}
Dog.prototype = new Animal()
// 哈士奇
var hashiqi = new Dog()
```

用 ES6 可以这样编写

```js
class Animal {
    constructor(name) {
        this.name = name
    }
    eat() {
        console.log(`${this.name} eat`)
    }
}

class Dog extends Animal {
    constructor(name) {
        super(name)
        this.name = name
    }
    say() {
        console.log(`${this.name} say`)
    }
}
const dog = new Dog('哈士奇')
dog.say()
dog.eat()
```

查看编译出来的 js 代码，会发现冗余代码更多，更加复杂了。

## 总结

用 class 做为构造函数，我个人感觉不如直接使用 function ，看起来更加直观，更加接近原理，而且编译出来没有冗余代码

但是，使用 es6 编写继承，比用 js 编写继承看起来更加统一，不像 js 编写继承那么琐碎。这是因为 class 的设计其实是借鉴了 java C# 这些经典面向对象语言的语法，让 js 看起来更加“面向对象”化

但是，无论语法怎样写，其中的原理你得明白，它还是逃不出原型和原型链的理论基础

待 es6 部分讲解完，会带领大家继续深入看 js 原型。
