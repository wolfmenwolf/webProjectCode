import React from 'react';
import { renderToString } from 'react-dom/server';
import { StaticRouter, Route, matchPath } from 'react-router-dom';
import routes from '../Routes';
import { Provider } from 'react-redux';
import getStore from '../store';

export const render = (req) => {

	const store = getStore();

	const matchRoutes = [];

	// 根据路由的路径，来往store里面加数据
	routes.some(route => {
	  const match = matchPath(req.path, route)
	  if (match) {
	  	matchRoutes.push(route)
	  }
	})

	// 让matchRoutes里面所有的组件，对应的loadData方法执行一次

	console.log(matchRoutes);


	const content = renderToString((
		<Provider store={store}>
			<StaticRouter location={req.path} context={{}}>
				<div>
					{routes.map(route => (
	      		<Route {...route}/>
	    		))}
    		</div>
			</StaticRouter>
		</Provider>
	));

	return `
		<html>
			<head>
				<title>ssr</title>
			</head>
			<body>
				<div id="root">${content}</div>
				<script src='/index.js'></script>
			</body>
		</html>
  `;
}