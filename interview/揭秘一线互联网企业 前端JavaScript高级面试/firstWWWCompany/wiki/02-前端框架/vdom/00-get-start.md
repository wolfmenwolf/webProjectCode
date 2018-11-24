# vdom

现在用到的前端主流框架 vue 或者 React ，里面都有 vdom ，目的就是为了提升渲染页面的效率。React 首次将 vdom 引入公众的视野，大家发现这东西真的非常快。vue 那时候还没有 vdom ，后来升级 2.0 就把 vdom 给引入进来，课件对 vdom 的认可。

高级面试题中肯定会被问到 vdom ，因为你无论在介绍 React 还是 vue 的实现逻辑的时候，都逃不出 vdom 。虽然 vdom 不会在工作中直接使用（除非你研究框架），但是会在面试中被直接问到。

本章介绍 vdom ，分以下几部分：

- 描述一个场景，引出 vdom
- 用一个现成的 vdom 库 https://github.com/snabbdom/snabbdom ，介绍一下 vdom 的基本应用
- 讲解 vdom 实现的核心逻辑和算法
- 总结
