# diff 算法

## 目录

- 什么是 diff 算法
- 讲过程不讲细节（去繁就简）
- vdom 为何要用 diff 算法
- diff 算法的实现逻辑
- 总结

## 什么是 diff 算法

你如果不是一名程序猿老兵，听说 diff 算法可能是在一些介绍 React 或者 vdom 的文章中。其实 diff 算法并不是 React 或者 vdom 发明的，它不是啥新鲜玩意儿。

> 计算机发展到现在，前端目前用的所谓新技术，只有微创新（即将以前原本有的再拿来改造一下），几乎没有从零创新

图（linux diff 工具），图（git diff），图（diff 在线工具）

上图演示的 diff 仅仅是对文本进行 diff ，跟我们的 vdom 没啥太多关系，但是原理是一样的。

实际演示一下上图中说的操作

## 将过程不讲细节（去繁就简）

> 有些代码写出来根本就不是为了给人阅读学习的，例如 v8 、sizzal 、包括 vue React 的部分源码

vdom 的 diff 算法非常复杂，有良好基础的人，想要了解其中的详细过程也不是一件容易的事儿。我试着用 ppt、流程图、源码 去讲解 snabbdom 的 diff 的详细实现过程，尽管我 ppt 重写了两遍，发现没那么容易讲解透彻，牵扯的东西实在太多。

因此，我现在重写了第三遍 ppt ，干脆把细节放下，把核心的过程讲解明白。让学生明白 diff 是什么、diff 的目的、diff 的基本实现逻辑（不要管细节），即所谓的 **“3W”** 。这样也比较符合 **28原则** 。 

总之我对自己的要求就是：**所有视频中的内容，我都要给大家讲解清楚**。如果某些部分不容易讲解清楚，那我们就抽象、总结、去繁就简也要讲解明白。

对于最终的目的 —— 高级面试 ，当面试官问到这个问题的时候，你能把我讲解的部分说清楚，至少能打 80 分。面试官也是咱们普通人，我就不相信所有的面试官都那么清楚 diff 的细节。

最后，不要觉得我这里去繁就简就变得没有挑战性了 —— 依然会非常烧脑。

## vdom 为何要用 diff 算法

前面讲过为何要使用 vdom 。再总结一下：

- DOM 操作是“昂贵”的，因此尽量减少 DOM 操作
- 找出本次 DOM 必须更新的节点，更新
- 找出的过程，就需要 diff 算法

举例说明：（表格 DOM 结构 vs 改变 data 之后的表格 DOM 结构，圈出改变的节点）

## diff 算法的实现逻辑

逻辑实现还要从核心函数`patch`说起

```js
patch(container, vnode)
patch(vnode, newVnode)
```

### `patch(container, vnode)`

首先看`patch(container, vnode)`，第一次渲染，container 是一个空的容器。将 vnode 变成 DOM 节点，然后填充进 container 中。

图示（左侧 vnode 右侧 DOM）

定义 createElement 方法来实现。**注意：createElement 后面后继续用到**

```js
    var tag = vnode.tag
    var attrs = vnode.attrs || {}
    var children = vnode.children || []
    if (!tag) {
        return null
    }
    // 创建元素
    var elem = document.createElement(tag)
    // 属性
    var attrName
    for (attrName in attrs) {
        if (attrs.hasOwnProperty(attrName)) {
            elem.setAttribute(attrName, attrs[attrName])
        }
    }
    // 子元素
    children.forEach(function (childVnode) {
        // 递归调用 createElementByVnode 创建子元素
        elem.appendChild(createElementByVnode(childVnode))
    })
    return elem
```

代码演示，code 中有代码。

### `patch(vnode, newVnode)`

之前已经通过`patch(container, vnode)`进行了初次渲染，之后`vnode`就和它创建出来的 DOM 节点 **关联起来了**。

图示（左侧 vnode 右侧 DOM）

再执行`patch(vnode, newVnode)`，其实就是找出`newVnode`相对于`vnode`的区别，然后将这些区别，更新到现有的 DOM 节点中。

**注意：diff 只做同级别的对比，不做跨级别的对比**

图示（左侧 vnode 右侧 newVnode，自己画几个模拟的节点）

先从跟节点对比开始，根节点肯定是一样的，因此要继续对比根节点的所有子节点。这个方法定义为`updateChildren`，简单写一个算法的描述，对比着上图解释

```js
function createElement(vnode) {
    // ....
}
function replaceNode (vnode, newVnode) {
    var elem = vnode.elem
    var newElem = createElement(newVnode)
    elem.parentNode.replaceChild(elem, newElem)
}
function updateChildren(vnode, newVnode) {
    var children = vnode.children || []
    var newChildren = newVnode.children || []

    // 判断是否是 <li>item 1</li> 这种形式
    var length = children.length
    var child = children[0]
    var newChild = newChildren[0]
    if (length === 1 && !child.tag) {
        // vnode 命中了 <li>item 1</li> 这种形式
        if (child !== newChild) {
            replaceNode(child, newChild)
        }
        return
    }
    // 遍历现有的 children
    children.forEach(function (child, index) {
        var newChild = newChildren[index]
        if (newChild == null) {
            return
        }
        if (child.tag === newChild.tag) {
            // 两者 tag 一样
            updateChildren(child, newChild)
        } else {
            // 两者 tag 不一样
            replaceNode(child, newChild)
        }
    })
}
```

## 总结

- 知道什么是 diff 算法
- vdom 用 diff 算法到底做了什么
- vdom 的基本流程 createElement updateChildren










