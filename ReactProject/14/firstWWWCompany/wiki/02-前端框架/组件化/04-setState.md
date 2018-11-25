# setState

如果从网上搜索 React setState 的文章，可能会搜出很多高大上的内容，看半天看不懂。其实 setState 就一个核心的特点——异步。


## rerender

rerender 的触发一般来自于`setState`即修改状态，拿`src/components/todo/index.js`看

```js
  addTitle(title) {
    const currentList = this.state.list
    this.setState({
      list: currentList.concat(title)
    })
  }
```

`list`被修改，即`state`被修改，会重新触发`render`函数，生成新的 vnode。

```jsx
  render() {
    return (
      <div>
        <Input addTitle={this.addTitle.bind(this)}/>
        <List data={this.state.list}/>
      </div>
    );
  }
```

新的 vnode 和之前初始化时候生成的 vnode 节点进行对比，即 diff 算法，然后按需重新渲染 dom 。

**需要注意的是，哪个组件的 state 被修改，就执行相应的 render 即可。其子组件肯定会受影响，但是其父组件不会受影响，这样就将影响范围收缩到最小。**

## 异步

如果同时执行多次`setState`，那么会不会每次都来一遍 rerender ？—— 肯定不会，因为：

- 没必要。一次执行多次 rerender ，中间执行的过程用户是看不到的，用户看到的只是最后的结果
- 性能问题。js 本来就单线程，而且 js 执行和 dom 渲染是互斥的，即 dom 渲染过程中 js 处于卡顿状态

因此，`setState`是异步的，无论你一次性执行多少遍`setState`，它都会先进入一个异步队列，当主线程的 js 执行完毕之后，再去统一执行异步队列的内容。这个过程完全符合此前讲的 js 异步的执行原理

```js
function enqueueRender(component) {
    if (!component.__d && (component.__d = !0) && 1 == items.push(component)) (options.debounceRendering || defer)(rerender);
}

setState: function(state, callback) {
    var s = this.state;
    if (!this.__s) this.__s = extend({}, s);
    extend(s, 'function' == typeof state ? state(s, this.props) : state);
    if (callback) (this.__h = this.__h || []).push(callback);
    enqueueRender(this);
}
```
