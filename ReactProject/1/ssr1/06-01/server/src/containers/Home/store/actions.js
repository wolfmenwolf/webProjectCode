import axios from 'axios';
import { CHANGE_LIST } from './constants';

const changeList = (list) => ({
	type: CHANGE_LIST,
	list
})

export const getHomeList = () => {
	// http://47.95.113.63/ssr/api/news.json?secret=abcd
	return (dispatch) => {
		return axios.get('/api/news.json?secret=abcd')
			.then((res) => {
				const list = res.data.data;
				dispatch(changeList(list))
			});
	}
} 