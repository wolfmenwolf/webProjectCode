import express from 'express';
import proxy from 'express-http-proxy';
import { matchRoutes } from 'react-router-config'
import { render } from './utils';
import { getStore } from '../store';
import routes from '../Routes';

const app = express();
app.use(express.static('public'));

// /api/news.json
// req.url = news.json
// proxyReqPathResolver: /ssr/api/news.json
// http://47.95.113.63 + proxyReqPathResolver()
// http://47.95.113.63/ssr/api/news.json

app.use('/api', proxy('http://47.95.113.63', {
  proxyReqPathResolver: function (req) {
    return '/ssr/api' + req.url;
  }
}));

app.get('*', function (req, res) {
	const store = getStore(req);
	// 根据路由的路径，来往store里面加数据
	const matchedRoutes = matchRoutes(routes, req.path);
	// 让matchRoutes里面所有的组件，对应的loadData方法执行一次
	const promises = [];

	matchedRoutes.forEach(item => {
		if (item.route.loadData) {
			const promise = new Promise((resolve, reject) => {
				item.route.loadData(store).then(resolve).catch(resolve);
			})
			promises.push(promise);
		}
	})

	// 一个页面要加载 A,B,C,D 四个组件，这四个组件都需要服务器端加载数据
	// 假设A组件加载数据错误

	// 一个页面要加载 A,B,C,D 四个组件，这四个组件都需要服务器端加载数据
	// 假设A组件加载数据错误
	// B, C, D 组件有几种情况
	// 1. B, C, D 组件数据已经加载完成了
	// 2. 假设B, C, D 接口比较慢，B, C, D 组件数据没有加载完成

	// promises = [ a, b, c, d ]
	Promise.all(promises).then(() => {
		const context = {};
		const html = render(store, routes, req, context);
		if (context.action === 'REPLACE') {
			res.redirect(301, context.url)
		}else if (context.NOT_FOUND) {
			res.status(404);
			res.send(html);
		}else {
			res.send(html);
		}
	})
});

var server = app.listen(3000);