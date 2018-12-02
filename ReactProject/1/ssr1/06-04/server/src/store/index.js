import { createStore, applyMiddleware, combineReducers } from 'redux';
import thunk from 'redux-thunk';
import { reducer as homeReducer } from '../containers/Home/store';
import clientAxios from '../client/request';
import serverAxios from '../server/request';

const reducer = combineReducers({
	home: homeReducer
});

export const getStore = () => {
	// 改变服务器端store的内容，那么就一定要使用serverAxios
	return createStore(reducer, applyMiddleware(thunk.withExtraArgument(serverAxios)));
}

export const getClientStore = () => {
	const defaultState = window.context.state;
	// 改变客户端store的内容，一定要使用clientAxios
	return createStore(reducer, defaultState, applyMiddleware(thunk.withExtraArgument(clientAxios)));
}