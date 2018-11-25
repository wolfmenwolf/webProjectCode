本 demo 在 redux-async-demo 的基础上对路由进行了更改~

#### 用到的技术（-> package.json）：

	"antd": "^2.12.8",
	"axios": "^0.16.2",
	"react": "^15.3.2",
	"react-dom": "^15.3.2",
	"react-redux": "^5.0.5",
	"react-router-dom": "^4.1.1",
	"redux": "^3.7.2",
	"redux-logger": "^3.0.6",
	"redux-saga": "^0.15.3",
	"redux-thunk": "^2.2.0"

#### 主要实现的功能：

1. 用 `react-router4` 实现路由切换
2. `redux-thunk` 异步加载数据
3. `redux-saga` 异步加载数据

#### 参考：

1） webpack-react 脚手架采用了之前的demo：[react\_webpack\\_scaffold](https://github.com/RukiQ/scaffoldsForFE/tree/master/react_webpack_scaffold)

2）页面样式参考了 [react-antd-demo](https://github.com/luckykun/About-React/tree/master/react-antd-demo)

3）[react router 4](https://reacttraining.com/react-router/web/example/basic)

请参考我的博文： [React Router 4：痛过之后的豁然开朗](http://www.jianshu.com/p/bf6b45ce5bcc)

4）对 redux 异步流的详细介绍请参考我的博文：[聊一聊 redux 异步流之 redux-saga](http://www.jianshu.com/p/e84493c7af35)



