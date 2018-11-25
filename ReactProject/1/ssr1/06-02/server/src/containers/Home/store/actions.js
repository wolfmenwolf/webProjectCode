import axios from 'axios';
import { CHANGE_LIST } from './constants';

const changeList = (list) => ({
	type: CHANGE_LIST,
	list
})

export const getHomeList = (server) => {
	// http://47.95.113.63/ssr/api/news.json?secret=abcd
	// 浏览器运行
	// /api/news.json = http://localhost:3000/api/news.json
	// 服务器运行
	// /api/news.json = 服务器根目录下/api/news.json
	let url = ''
	if (server) {
		url = 'http://47.95.113.63/ssr/api/news.json?secret=abcd'
	}else {
		url = '/api/news.json?secret=abcd'
	}

	return (dispatch) => {
		return axios.get(url)
			.then((res) => {
				const list = res.data.data;
				dispatch(changeList(list))
			});
	}
} 