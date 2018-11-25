# jsx

**先从 demo 中看一下什么是 JSX**

## jsx 语法

- 普通标签
- 引入 js 变量和表达式
- if else
- 循环
- style 和 className
- 事件

（初始化一个空 React 开发环境，代码演示）

## 答题

先来回答一下上一节提出的问题。

如果编写的 jsx 代码是这样的

```jsx
/* JSX 代码 */
var profile = <div>
                <img src="avatar.png" className="profile" />
                <h3>{[user.firstName, user.lastName].join(' ')}</h3>
              </div>;
```

编译之后的结果是：

```js
// 解析结果
var profile = React.createElement("div", null,
  React.createElement("img", { src: "avatar.png", className: "profile" }),
  React.createElement("h3", null, [user.firstName, user.lastName].join(" "))
);
```

```js
// React.createElement 参数说明
React.createElement('div', {id: 'div1'}, child1, child2, child3)
React.createElement('div', {id: 'div1'}, [...])
```

看明白了吧，js 代码中有了`React.createElement`，因此必须要`import React from 'react';`

**引入这个问题的目的**：说明 jsx 是一个语法糖，它不能真正被浏览器执行，它需要编译为 js 。编译是在开发环境，项目发布之前就搞定的。因此，我们编写的 jsx 代码，会以 js 代码的形式上线、执行。

其实你完全可以用下面的方式编写 React 代码，但是那样编写和阅读的复杂度都太高了，jsx 是一个非常好的创新。

## 独立标准

jsx 虽然是从 React 中提出来的概念，但是它已经发展成了一个独立的语法，你完全可以将 jsx 的语法特性用于其他项目或者自己的项目。上面代码中的`React.createElement`完全可以替换成其他函数，例如 PReact 中替换为`h`

可以用 babel 编译试一下

- 创建一个目录，`npm init` ，然后创建一个`demo.jsx`文件。
- 全局安装 babel
- `npm install --save-dev babel-plugin-transform-react-jsx --registry=https://registry.npm.taobao.org`
- 创建`.babelrc` ，内容`{ "plugins": ["transform-react-jsx"] }`
- 运行`babel --plugins transform-react-jsx demo.jsx` 可以看到结果，但是函数是`React.createElement`（默认情况下）
- 这里的`React.createElement`是可以修改的，例如在`demo.jsx`第一行加入`/* @jsx $ */` （也可以通过配置`.babelrc`进行修改，但这不是重点）

再讲一下`React.createElement`各个参数的含义

- 第一个参数如果是字符串，即 html 标签的名字。如果是函数，即我们自己定义的组件
- 第二个参数是所有的属性，没有就传入`null`
- 第三个参数以及后面所有的参数，都是该组件的子元素。（也支持第三个参数是数组的形式）

## 生成 vdom

```js
var profile = React.createElement("div", null,
  React.createElement("img", { src: "avatar.png", className: "profile" }),
  React.createElement("h3", null, [user.firstName, user.lastName].join(" "))
);
```

`React.createElement`生成的是一个 vnode，例如

```js
{
  tag: 'div',
  attrs: {},
  children: [
    {
      tag: 'img',
      attrs: {
        src: "avatar.png",
        className: "profile"
      },
      children: []
    },
    {
      tag: 'h3',
      attrs: {},
      children: [
        [user.firstName, user.lastName].join(" ")
      ]
    }
  ]
}
```


## 自定组件的处理

demo 中

```jsx
return (
  <div>
    <Input addTitle={this.addTitle.bind(this)}/>
    <List data={this.state.list}/>
  </div>
);
```

最终生成

```js
return React.createElement('div', null,
    React.createElement(Input, {addTitle: this.addTitle.bind(this)}),
    React.createElement(List, {data: this.state.list})
)
```

注意这里的`'div'` `Input` `List`

- `'div'`很好理解，渲染一个`<div>`就行了
- `Input`和`List`，不是常规的 html 标签，无法直接渲染。因此需要根据 props 创建实例，然后执行实例的 render 函数

例如`List`的 render 函数是这样的

```jsx
  /* List 组件的 render 函数 */
  render() {
    const list = this.props.data
    return (
      <ul>
          {
            list.map((item, index) => {
                return <li key={index}>{item}</li>
            })
          }
      </ul>
    );
  }
```

经过编译之后，会得到

```js
function render() {
    const list = this.props.data;
    return React.createElement(
        "ul",
        null,
        list.map((item, index) => {
            return React.createElement(
                "li",
                { key: index },
                item
            );
        })
    );
}
```

> 其实，`div`等常规的 html 标签，在 React 看来也是一个组件，只不过它内置了而已。**这块组件的抽象，应该放在前面，统一讲一下？？？**


## 分析 demo

分析一下 demo 中各个组件的 jsx 都生成了什么代码。

### `src/index.js`

源代码

```jsx
import App from './App';
ReactDOM.render(<App />, document.getElementById('root'));
```

编译完

```js
import App from './App';
ReactDOM.render(React.createElement(App, null), document.getElementById('root'));
```

上文提到过`React.createElement`返回的是一个 vnode ，这个 vnode 交给`ReactDOM.render`去渲染，最终渲染到`document.getElementById('root')`这个真是的 DOM 节点上。

要渲染真是 DOM 肯定得对应到真实的 html 标签，这里的`App`不行。因此得去初始化`App`的实例，然后去执行 render 函数。

### `src/app.js`

源代码

```jsx
import Todo from './components/todo'
class App extends Component {
  render() {
    return (
      <div>
        <Todo/>
      </div>
    );
  }
}
```

编译完成后

```js
import Todo from './components/todo'
class App extends Component {
  render() {
    return React.createElement(
      "div",
      null,
      React.createElement(Todo, null)
    );
  }
}
```

同理，`Todo`也需要创建示例且执行 render 函数

### `src/components/todo/index.js`

源代码

```jsx
import Input from './input'
import List from './list'
class Todo extends Component {
  render() {
    return (
      <div>
        <Input addTitle={this.addTitle.bind(this)}/>
        <List data={this.state.list}/>
      </div>
    );
  }
}
```

编译完之后

```js
import Input from './input';
import List from './list';
class Todo extends Component {
  render() {
    return React.createElement(
      'div',
      null,
      React.createElement(Input, { addTitle: this.addTitle.bind(this) }),
      React.createElement(List, { data: this.state.list })
    );
  }
}
```

同理，`Input`和`List`都需要创建实例（**注意，创建实例要传入 props ，上面的 props 都是 null ，因此没强调**），然后执行 render 函数

### `src/components/todo/input/index.js`

源代码

```jsx
class Input extends Component {
  render() {
    return (
      <div>
          <input value={this.state.title} onChange={this.changeHandle.bind(this)}/>
          <button onClick={this.clickHandle.bind(this)}>submit</button>
      </div>
    );
  }
}
```

编译完之后

```js
class Input extends Component {
  render() {
    return React.createElement(
      "div",
      null,
      React.createElement("input", { value: this.state.title, onChange: this.changeHandle.bind(this) }),
      React.createElement(
        "button",
        { onClick: this.clickHandle.bind(this) },
        "submit"
      )
    );
  }
}
```

到此为止，就全部都是标准的 html 标签了。**你无论自定义了多少层组件，归根结底都需要 html 标签来实现，关键是这个结构和过程要明白**。

### `src/components/todo/list/index.js`

例如`List`的 render 函数是这样的

```jsx
  render() {
    const list = this.props.data
    return (
      <ul>
          {
            list.map((item, index) => {
                return <li key={index}>{item}</li>
            })
          }
      </ul>
    );
  }
```

经过编译之后，会得到

```js
function render() {
    const list = this.props.data;
    return React.createElement(
        "ul",
        null,
        list.map((item, index) => {
            return React.createElement(
                "li",
                { key: index },
                item
            );
        })
    );
}
```

这里`React.createElement`第三个参数是数组，也可以被识别为子元素

### 回到`src/index.js`

虽然`src/index.js`看似只有`React.createElement(App, null)`，但是经过后面的分析，可以发现它展开之后，其实是一个有很多子节点的 vnode ，因为我们定义的很多子组件。

最终这个 vnode 还是被渲染到了页面指定的地方，生成了视图。
