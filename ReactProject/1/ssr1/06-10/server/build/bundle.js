/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./src/server/index.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./src/App.js":
/*!********************!*\
  !*** ./src/App.js ***!
  \********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\n\nvar _react = __webpack_require__(/*! react */ \"react\");\n\nvar _react2 = _interopRequireDefault(_react);\n\nvar _Header = __webpack_require__(/*! ./components/Header/ */ \"./src/components/Header/index.js\");\n\nvar _Header2 = _interopRequireDefault(_Header);\n\nvar _reactRouterConfig = __webpack_require__(/*! react-router-config */ \"react-router-config\");\n\nvar _store = __webpack_require__(/*! ./components/Header/store/ */ \"./src/components/Header/store/index.js\");\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\nvar App = function App(props) {\n\treturn _react2.default.createElement(\n\t\t'div',\n\t\tnull,\n\t\t_react2.default.createElement(_Header2.default, null),\n\t\t(0, _reactRouterConfig.renderRoutes)(props.route.routes)\n\t);\n};\n\nApp.loadData = function (store) {\n\treturn store.dispatch(_store.actions.getHeaderInfo());\n};\n\nexports.default = App;\n\n//# sourceURL=webpack:///./src/App.js?");

/***/ }),

/***/ "./src/Routes.js":
/*!***********************!*\
  !*** ./src/Routes.js ***!
  \***********************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n  value: true\n});\n\nvar _react = __webpack_require__(/*! react */ \"react\");\n\nvar _react2 = _interopRequireDefault(_react);\n\nvar _reactRouterDom = __webpack_require__(/*! react-router-dom */ \"react-router-dom\");\n\nvar _App = __webpack_require__(/*! ./App */ \"./src/App.js\");\n\nvar _App2 = _interopRequireDefault(_App);\n\nvar _Home = __webpack_require__(/*! ./containers/Home */ \"./src/containers/Home/index.js\");\n\nvar _Home2 = _interopRequireDefault(_Home);\n\nvar _Translation = __webpack_require__(/*! ./containers/Translation */ \"./src/containers/Translation/index.js\");\n\nvar _Translation2 = _interopRequireDefault(_Translation);\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\n// 当我加载显示HOME组件之前，我希望调用Home.loadData方法，提前获取到必要的异步数据\n// 然后再做服务器端渲染，把页面返回给用户\nexports.default = [{\n  path: '/',\n  component: _App2.default,\n  loadData: _App2.default.loadData,\n  routes: [{\n    path: '/',\n    component: _Home2.default,\n    exact: true,\n    loadData: _Home2.default.loadData,\n    key: 'home'\n  }, {\n    path: '/translation',\n    component: _Translation2.default,\n    loadData: _Translation2.default.loadData,\n    exact: true,\n    key: 'translation'\n  }]\n}];\n\n//# sourceURL=webpack:///./src/Routes.js?");

/***/ }),

/***/ "./src/client/request.js":
/*!*******************************!*\
  !*** ./src/client/request.js ***!
  \*******************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\n\nvar _axios = __webpack_require__(/*! axios */ \"axios\");\n\nvar _axios2 = _interopRequireDefault(_axios);\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\nvar instance = _axios2.default.create({\n\tbaseURL: '/'\n});\n\nexports.default = instance;\n\n//# sourceURL=webpack:///./src/client/request.js?");

/***/ }),

/***/ "./src/components/Header/index.js":
/*!****************************************!*\
  !*** ./src/components/Header/index.js ***!
  \****************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\n\nvar _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if (\"value\" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();\n\nvar _react = __webpack_require__(/*! react */ \"react\");\n\nvar _react2 = _interopRequireDefault(_react);\n\nvar _reactRouterDom = __webpack_require__(/*! react-router-dom */ \"react-router-dom\");\n\nvar _reactRedux = __webpack_require__(/*! react-redux */ \"react-redux\");\n\nvar _store = __webpack_require__(/*! ./store/ */ \"./src/components/Header/store/index.js\");\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\nfunction _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError(\"Cannot call a class as a function\"); } }\n\nfunction _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError(\"this hasn't been initialised - super() hasn't been called\"); } return call && (typeof call === \"object\" || typeof call === \"function\") ? call : self; }\n\nfunction _inherits(subClass, superClass) { if (typeof superClass !== \"function\" && superClass !== null) { throw new TypeError(\"Super expression must either be null or a function, not \" + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }\n\nvar Header = function (_Component) {\n\t_inherits(Header, _Component);\n\n\tfunction Header() {\n\t\t_classCallCheck(this, Header);\n\n\t\treturn _possibleConstructorReturn(this, (Header.__proto__ || Object.getPrototypeOf(Header)).apply(this, arguments));\n\t}\n\n\t_createClass(Header, [{\n\t\tkey: 'render',\n\t\tvalue: function render() {\n\t\t\tvar _props = this.props,\n\t\t\t    login = _props.login,\n\t\t\t    handleLogin = _props.handleLogin,\n\t\t\t    handleLogout = _props.handleLogout;\n\n\t\t\treturn _react2.default.createElement(\n\t\t\t\t'div',\n\t\t\t\tnull,\n\t\t\t\t_react2.default.createElement(\n\t\t\t\t\t_reactRouterDom.Link,\n\t\t\t\t\t{ to: '/' },\n\t\t\t\t\t'\\u9996\\u9875'\n\t\t\t\t),\n\t\t\t\t_react2.default.createElement('br', null),\n\t\t\t\tlogin ? _react2.default.createElement(\n\t\t\t\t\t_react.Fragment,\n\t\t\t\t\tnull,\n\t\t\t\t\t_react2.default.createElement(\n\t\t\t\t\t\t_reactRouterDom.Link,\n\t\t\t\t\t\t{ to: '/translation' },\n\t\t\t\t\t\t'\\u7FFB\\u8BD1\\u5217\\u8868'\n\t\t\t\t\t),\n\t\t\t\t\t_react2.default.createElement('br', null),\n\t\t\t\t\t_react2.default.createElement(\n\t\t\t\t\t\t'div',\n\t\t\t\t\t\t{ onClick: handleLogout },\n\t\t\t\t\t\t'\\u9000\\u51FA'\n\t\t\t\t\t)\n\t\t\t\t) : _react2.default.createElement(\n\t\t\t\t\t'div',\n\t\t\t\t\t{ onClick: handleLogin },\n\t\t\t\t\t'\\u767B\\u9646'\n\t\t\t\t)\n\t\t\t);\n\t\t}\n\t}]);\n\n\treturn Header;\n}(_react.Component);\n\nvar mapState = function mapState(state) {\n\treturn {\n\t\tlogin: state.header.login\n\t};\n};\n\nvar mapDispatch = function mapDispatch(dispatch) {\n\treturn {\n\t\thandleLogin: function handleLogin() {\n\t\t\tdispatch(_store.actions.login());\n\t\t},\n\t\thandleLogout: function handleLogout() {\n\t\t\tdispatch(_store.actions.logout());\n\t\t}\n\t};\n};\n\nexports.default = (0, _reactRedux.connect)(mapState, mapDispatch)(Header);\n\n//# sourceURL=webpack:///./src/components/Header/index.js?");

/***/ }),

/***/ "./src/components/Header/store/actions.js":
/*!************************************************!*\
  !*** ./src/components/Header/store/actions.js ***!
  \************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\nexports.getHeaderInfo = exports.logout = exports.login = undefined;\n\nvar _constants = __webpack_require__(/*! ./constants */ \"./src/components/Header/store/constants.js\");\n\nvar changeLogin = function changeLogin(value) {\n\treturn {\n\t\ttype: _constants.CHANGE_LOGIN,\n\t\tvalue: value\n\t};\n};\n\nvar login = exports.login = function login() {\n\treturn function (dispatch, getState, axiosInstance) {\n\t\treturn axiosInstance.get('/api/login.json?secret=abcd').then(function (res) {\n\t\t\tdispatch(changeLogin(true));\n\t\t});\n\t};\n};\n\nvar logout = exports.logout = function logout() {\n\treturn function (dispatch, getState, axiosInstance) {\n\t\treturn axiosInstance.get('/api/logout.json?secret=abcd').then(function (res) {\n\t\t\tdispatch(changeLogin(false));\n\t\t});\n\t};\n};\n\nvar getHeaderInfo = exports.getHeaderInfo = function getHeaderInfo() {\n\treturn function (dispatch, getState, axiosInstance) {\n\t\treturn axiosInstance.get('/api/isLogin.json?secret=abcd').then(function (res) {\n\t\t\tdispatch(changeLogin(res.data.data.login));\n\t\t});\n\t};\n};\n\n//# sourceURL=webpack:///./src/components/Header/store/actions.js?");

/***/ }),

/***/ "./src/components/Header/store/constants.js":
/*!**************************************************!*\
  !*** ./src/components/Header/store/constants.js ***!
  \**************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n  value: true\n});\nvar CHANGE_LOGIN = exports.CHANGE_LOGIN = 'HEADER/CHANGER_LOGIN';\n\n//# sourceURL=webpack:///./src/components/Header/store/constants.js?");

/***/ }),

/***/ "./src/components/Header/store/index.js":
/*!**********************************************!*\
  !*** ./src/components/Header/store/index.js ***!
  \**********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n  value: true\n});\nexports.actions = exports.reducer = undefined;\n\nvar _reducer = __webpack_require__(/*! ./reducer */ \"./src/components/Header/store/reducer.js\");\n\nvar _reducer2 = _interopRequireDefault(_reducer);\n\nvar _actions = __webpack_require__(/*! ./actions */ \"./src/components/Header/store/actions.js\");\n\nvar actions = _interopRequireWildcard(_actions);\n\nfunction _interopRequireWildcard(obj) { if (obj && obj.__esModule) { return obj; } else { var newObj = {}; if (obj != null) { for (var key in obj) { if (Object.prototype.hasOwnProperty.call(obj, key)) newObj[key] = obj[key]; } } newObj.default = obj; return newObj; } }\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\nexports.reducer = _reducer2.default;\nexports.actions = actions;\n\n//# sourceURL=webpack:///./src/components/Header/store/index.js?");

/***/ }),

/***/ "./src/components/Header/store/reducer.js":
/*!************************************************!*\
  !*** ./src/components/Header/store/reducer.js ***!
  \************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\n\nvar _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };\n\nvar _constants = __webpack_require__(/*! ./constants */ \"./src/components/Header/store/constants.js\");\n\nvar defaultState = {\n\tlogin: true\n};\n\nexports.default = function () {\n\tvar state = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : defaultState;\n\tvar action = arguments[1];\n\n\tswitch (action.type) {\n\t\tcase _constants.CHANGE_LOGIN:\n\t\t\treturn _extends({}, state, {\n\t\t\t\tlogin: action.value\n\t\t\t});\n\t\tdefault:\n\t\t\treturn state;\n\t}\n};\n\n//# sourceURL=webpack:///./src/components/Header/store/reducer.js?");

/***/ }),

/***/ "./src/containers/Home/index.js":
/*!**************************************!*\
  !*** ./src/containers/Home/index.js ***!
  \**************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\n\nvar _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if (\"value\" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();\n\nvar _react = __webpack_require__(/*! react */ \"react\");\n\nvar _react2 = _interopRequireDefault(_react);\n\nvar _reactRedux = __webpack_require__(/*! react-redux */ \"react-redux\");\n\nvar _actions = __webpack_require__(/*! ./store/actions */ \"./src/containers/Home/store/actions.js\");\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\nfunction _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError(\"Cannot call a class as a function\"); } }\n\nfunction _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError(\"this hasn't been initialised - super() hasn't been called\"); } return call && (typeof call === \"object\" || typeof call === \"function\") ? call : self; }\n\nfunction _inherits(subClass, superClass) { if (typeof superClass !== \"function\" && superClass !== null) { throw new TypeError(\"Super expression must either be null or a function, not \" + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }\n\nvar Home = function (_Component) {\n\t_inherits(Home, _Component);\n\n\tfunction Home() {\n\t\t_classCallCheck(this, Home);\n\n\t\treturn _possibleConstructorReturn(this, (Home.__proto__ || Object.getPrototypeOf(Home)).apply(this, arguments));\n\t}\n\n\t_createClass(Home, [{\n\t\tkey: 'getList',\n\t\tvalue: function getList() {\n\t\t\tvar list = this.props.list;\n\n\t\t\treturn list.map(function (item) {\n\t\t\t\treturn _react2.default.createElement(\n\t\t\t\t\t'div',\n\t\t\t\t\t{ key: item.id },\n\t\t\t\t\titem.title\n\t\t\t\t);\n\t\t\t});\n\t\t}\n\t}, {\n\t\tkey: 'render',\n\t\tvalue: function render() {\n\t\t\treturn _react2.default.createElement(\n\t\t\t\t'div',\n\t\t\t\tnull,\n\t\t\t\tthis.getList(),\n\t\t\t\t_react2.default.createElement(\n\t\t\t\t\t'button',\n\t\t\t\t\t{ onClick: function onClick() {\n\t\t\t\t\t\t\talert('click1');\n\t\t\t\t\t\t} },\n\t\t\t\t\t'click'\n\t\t\t\t)\n\t\t\t);\n\t\t}\n\t}, {\n\t\tkey: 'componentDidMount',\n\t\tvalue: function componentDidMount() {\n\t\t\tif (!this.props.list.length) {\n\t\t\t\tthis.props.getHomeList();\n\t\t\t}\n\t\t}\n\t}]);\n\n\treturn Home;\n}(_react.Component);\n\nHome.loadData = function (store) {\n\t// 这个函数，负责在服务器端渲染之前，把这个路由需要的数据提前加载好\n\treturn store.dispatch((0, _actions.getHomeList)());\n};\n\nvar mapStateToProps = function mapStateToProps(state) {\n\treturn {\n\t\tlist: state.home.newsList\n\t};\n};\n\nvar mapDispatchToProps = function mapDispatchToProps(dispatch) {\n\treturn {\n\t\tgetHomeList: function getHomeList() {\n\t\t\tdispatch((0, _actions.getHomeList)());\n\t\t}\n\t};\n};\n\nexports.default = (0, _reactRedux.connect)(mapStateToProps, mapDispatchToProps)(Home);\n\n//# sourceURL=webpack:///./src/containers/Home/index.js?");

/***/ }),

/***/ "./src/containers/Home/store/actions.js":
/*!**********************************************!*\
  !*** ./src/containers/Home/store/actions.js ***!
  \**********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\nexports.getHomeList = undefined;\n\nvar _constants = __webpack_require__(/*! ./constants */ \"./src/containers/Home/store/constants.js\");\n\nvar changeList = function changeList(list) {\n\treturn {\n\t\ttype: _constants.CHANGE_LIST,\n\t\tlist: list\n\t};\n};\n\nvar getHomeList = exports.getHomeList = function getHomeList() {\n\treturn function (dispatch, getState, axiosInstance) {\n\t\treturn axiosInstance.get('/api/news.json?secret=abcd').then(function (res) {\n\t\t\tvar list = res.data.data;\n\t\t\tdispatch(changeList(list));\n\t\t});\n\t};\n};\n\n//# sourceURL=webpack:///./src/containers/Home/store/actions.js?");

/***/ }),

/***/ "./src/containers/Home/store/constants.js":
/*!************************************************!*\
  !*** ./src/containers/Home/store/constants.js ***!
  \************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n  value: true\n});\nvar CHANGE_LIST = exports.CHANGE_LIST = 'HOME/CHANGE_LIST';\n\n//# sourceURL=webpack:///./src/containers/Home/store/constants.js?");

/***/ }),

/***/ "./src/containers/Home/store/index.js":
/*!********************************************!*\
  !*** ./src/containers/Home/store/index.js ***!
  \********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n  value: true\n});\nexports.reducer = undefined;\n\nvar _reducer = __webpack_require__(/*! ./reducer */ \"./src/containers/Home/store/reducer.js\");\n\nvar _reducer2 = _interopRequireDefault(_reducer);\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\nexports.reducer = _reducer2.default;\n\n//# sourceURL=webpack:///./src/containers/Home/store/index.js?");

/***/ }),

/***/ "./src/containers/Home/store/reducer.js":
/*!**********************************************!*\
  !*** ./src/containers/Home/store/reducer.js ***!
  \**********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\n\nvar _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };\n\nvar _constants = __webpack_require__(/*! ./constants */ \"./src/containers/Home/store/constants.js\");\n\nvar defaultState = {\n\tnewsList: []\n};\n\nexports.default = function () {\n\tvar state = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : defaultState;\n\tvar action = arguments[1];\n\n\tswitch (action.type) {\n\t\tcase _constants.CHANGE_LIST:\n\t\t\treturn _extends({}, state, {\n\t\t\t\tnewsList: action.list\n\t\t\t});\n\t\tdefault:\n\t\t\treturn state;\n\t}\n};\n\n//# sourceURL=webpack:///./src/containers/Home/store/reducer.js?");

/***/ }),

/***/ "./src/containers/Translation/index.js":
/*!*********************************************!*\
  !*** ./src/containers/Translation/index.js ***!
  \*********************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\n\nvar _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if (\"value\" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();\n\nvar _react = __webpack_require__(/*! react */ \"react\");\n\nvar _react2 = _interopRequireDefault(_react);\n\nvar _reactRedux = __webpack_require__(/*! react-redux */ \"react-redux\");\n\nvar _actions = __webpack_require__(/*! ./store/actions */ \"./src/containers/Translation/store/actions.js\");\n\nvar _reactRouterDom = __webpack_require__(/*! react-router-dom */ \"react-router-dom\");\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\nfunction _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError(\"Cannot call a class as a function\"); } }\n\nfunction _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError(\"this hasn't been initialised - super() hasn't been called\"); } return call && (typeof call === \"object\" || typeof call === \"function\") ? call : self; }\n\nfunction _inherits(subClass, superClass) { if (typeof superClass !== \"function\" && superClass !== null) { throw new TypeError(\"Super expression must either be null or a function, not \" + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }\n\nvar Translation = function (_Component) {\n\t_inherits(Translation, _Component);\n\n\tfunction Translation() {\n\t\t_classCallCheck(this, Translation);\n\n\t\treturn _possibleConstructorReturn(this, (Translation.__proto__ || Object.getPrototypeOf(Translation)).apply(this, arguments));\n\t}\n\n\t_createClass(Translation, [{\n\t\tkey: 'getList',\n\t\tvalue: function getList() {\n\t\t\tvar list = this.props.list;\n\n\t\t\treturn list.map(function (item) {\n\t\t\t\treturn _react2.default.createElement(\n\t\t\t\t\t'div',\n\t\t\t\t\t{ key: item.id },\n\t\t\t\t\titem.title\n\t\t\t\t);\n\t\t\t});\n\t\t}\n\t}, {\n\t\tkey: 'render',\n\t\tvalue: function render() {\n\t\t\treturn this.props.login ? _react2.default.createElement(\n\t\t\t\t'div',\n\t\t\t\tnull,\n\t\t\t\tthis.getList()\n\t\t\t) : _react2.default.createElement(_reactRouterDom.Redirect, { to: '/' });\n\t\t}\n\t}, {\n\t\tkey: 'componentDidMount',\n\t\tvalue: function componentDidMount() {\n\t\t\tif (!this.props.list.length) {\n\t\t\t\tthis.props.getTranslationList();\n\t\t\t}\n\t\t}\n\t}]);\n\n\treturn Translation;\n}(_react.Component);\n\nTranslation.loadData = function (store) {\n\treturn store.dispatch((0, _actions.getTranslationList)());\n};\n\nvar mapStateToProps = function mapStateToProps(state) {\n\treturn {\n\t\tlist: state.translation.translationList,\n\t\tlogin: state.header.login\n\t};\n};\n\nvar mapDispatchToProps = function mapDispatchToProps(dispatch) {\n\treturn {\n\t\tgetTranslationList: function getTranslationList() {\n\t\t\tdispatch((0, _actions.getTranslationList)());\n\t\t}\n\t};\n};\n\nexports.default = (0, _reactRedux.connect)(mapStateToProps, mapDispatchToProps)(Translation);\n\n//# sourceURL=webpack:///./src/containers/Translation/index.js?");

/***/ }),

/***/ "./src/containers/Translation/store/actions.js":
/*!*****************************************************!*\
  !*** ./src/containers/Translation/store/actions.js ***!
  \*****************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\nexports.getTranslationList = undefined;\n\nvar _constants = __webpack_require__(/*! ./constants */ \"./src/containers/Translation/store/constants.js\");\n\nvar changeList = function changeList(list) {\n\treturn {\n\t\ttype: _constants.CHANGE_LIST,\n\t\tlist: list\n\t};\n};\n\nvar getTranslationList = exports.getTranslationList = function getTranslationList() {\n\treturn function (dispatch, getState, axiosInstance) {\n\t\treturn axiosInstance.get('/api/translations.json?secret=abcd').then(function (res) {\n\t\t\tif (res.data.success) {\n\t\t\t\tvar list = res.data.data;\n\t\t\t\tdispatch(changeList(list));\n\t\t\t} else {\n\t\t\t\tvar _list = [];\n\t\t\t\tdispatch(changeList(_list));\n\t\t\t}\n\t\t});\n\t};\n};\n\n//# sourceURL=webpack:///./src/containers/Translation/store/actions.js?");

/***/ }),

/***/ "./src/containers/Translation/store/constants.js":
/*!*******************************************************!*\
  !*** ./src/containers/Translation/store/constants.js ***!
  \*******************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n  value: true\n});\nvar CHANGE_LIST = exports.CHANGE_LIST = 'TRANSLATION/CHANGE_LIST';\n\n//# sourceURL=webpack:///./src/containers/Translation/store/constants.js?");

/***/ }),

/***/ "./src/containers/Translation/store/index.js":
/*!***************************************************!*\
  !*** ./src/containers/Translation/store/index.js ***!
  \***************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n  value: true\n});\nexports.reducer = undefined;\n\nvar _reducer = __webpack_require__(/*! ./reducer */ \"./src/containers/Translation/store/reducer.js\");\n\nvar _reducer2 = _interopRequireDefault(_reducer);\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\nexports.reducer = _reducer2.default;\n\n//# sourceURL=webpack:///./src/containers/Translation/store/index.js?");

/***/ }),

/***/ "./src/containers/Translation/store/reducer.js":
/*!*****************************************************!*\
  !*** ./src/containers/Translation/store/reducer.js ***!
  \*****************************************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\n\nvar _extends = Object.assign || function (target) { for (var i = 1; i < arguments.length; i++) { var source = arguments[i]; for (var key in source) { if (Object.prototype.hasOwnProperty.call(source, key)) { target[key] = source[key]; } } } return target; };\n\nvar _constants = __webpack_require__(/*! ./constants */ \"./src/containers/Translation/store/constants.js\");\n\nvar defaultState = {\n\ttranslationList: []\n};\n\nexports.default = function () {\n\tvar state = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : defaultState;\n\tvar action = arguments[1];\n\n\tswitch (action.type) {\n\t\tcase _constants.CHANGE_LIST:\n\t\t\treturn _extends({}, state, {\n\t\t\t\ttranslationList: action.list\n\t\t\t});\n\t\tdefault:\n\t\t\treturn state;\n\t}\n};\n\n//# sourceURL=webpack:///./src/containers/Translation/store/reducer.js?");

/***/ }),

/***/ "./src/server/index.js":
/*!*****************************!*\
  !*** ./src/server/index.js ***!
  \*****************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nvar _express = __webpack_require__(/*! express */ \"express\");\n\nvar _express2 = _interopRequireDefault(_express);\n\nvar _expressHttpProxy = __webpack_require__(/*! express-http-proxy */ \"express-http-proxy\");\n\nvar _expressHttpProxy2 = _interopRequireDefault(_expressHttpProxy);\n\nvar _reactRouterConfig = __webpack_require__(/*! react-router-config */ \"react-router-config\");\n\nvar _utils = __webpack_require__(/*! ./utils */ \"./src/server/utils.js\");\n\nvar _store = __webpack_require__(/*! ../store */ \"./src/store/index.js\");\n\nvar _Routes = __webpack_require__(/*! ../Routes */ \"./src/Routes.js\");\n\nvar _Routes2 = _interopRequireDefault(_Routes);\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\nvar app = (0, _express2.default)();\napp.use(_express2.default.static('public'));\n\n// /api/news.json\n// req.url = news.json\n// proxyReqPathResolver: /ssr/api/news.json\n// http://47.95.113.63 + proxyReqPathResolver()\n// http://47.95.113.63/ssr/api/news.json\n\napp.use('/api', (0, _expressHttpProxy2.default)('http://47.95.113.63', {\n\tproxyReqPathResolver: function proxyReqPathResolver(req) {\n\t\treturn '/ssr/api' + req.url;\n\t}\n}));\n\napp.get('*', function (req, res) {\n\tvar store = (0, _store.getStore)(req);\n\t// 根据路由的路径，来往store里面加数据\n\tvar matchedRoutes = (0, _reactRouterConfig.matchRoutes)(_Routes2.default, req.path);\n\t// 让matchRoutes里面所有的组件，对应的loadData方法执行一次\n\tvar promises = [];\n\tmatchedRoutes.forEach(function (item) {\n\t\tif (item.route.loadData) {\n\t\t\tpromises.push(item.route.loadData(store));\n\t\t}\n\t});\n\tPromise.all(promises).then(function () {\n\t\tres.send((0, _utils.render)(store, _Routes2.default, req));\n\t});\n});\n\nvar server = app.listen(3000);\n\n//# sourceURL=webpack:///./src/server/index.js?");

/***/ }),

/***/ "./src/server/request.js":
/*!*******************************!*\
  !*** ./src/server/request.js ***!
  \*******************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\n\nvar _axios = __webpack_require__(/*! axios */ \"axios\");\n\nvar _axios2 = _interopRequireDefault(_axios);\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\nvar createInstance = function createInstance(req) {\n\treturn _axios2.default.create({\n\t\tbaseURL: 'http://47.95.113.63/ssr',\n\t\theaders: {\n\t\t\tcookie: req.get('cookie') || ''\n\t\t}\n\t});\n};\n\nexports.default = createInstance;\n\n//# sourceURL=webpack:///./src/server/request.js?");

/***/ }),

/***/ "./src/server/utils.js":
/*!*****************************!*\
  !*** ./src/server/utils.js ***!
  \*****************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\nexports.render = undefined;\n\nvar _react = __webpack_require__(/*! react */ \"react\");\n\nvar _react2 = _interopRequireDefault(_react);\n\nvar _server = __webpack_require__(/*! react-dom/server */ \"react-dom/server\");\n\nvar _reactRouterDom = __webpack_require__(/*! react-router-dom */ \"react-router-dom\");\n\nvar _reactRouterConfig = __webpack_require__(/*! react-router-config */ \"react-router-config\");\n\nvar _reactRedux = __webpack_require__(/*! react-redux */ \"react-redux\");\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\nvar render = exports.render = function render(store, routes, req) {\n\n\tvar content = (0, _server.renderToString)(_react2.default.createElement(\n\t\t_reactRedux.Provider,\n\t\t{ store: store },\n\t\t_react2.default.createElement(\n\t\t\t_reactRouterDom.StaticRouter,\n\t\t\t{ location: req.path, context: {} },\n\t\t\t_react2.default.createElement(\n\t\t\t\t'div',\n\t\t\t\tnull,\n\t\t\t\t(0, _reactRouterConfig.renderRoutes)(routes)\n\t\t\t)\n\t\t)\n\t));\n\n\treturn '\\n\\t\\t\\t<html>\\n\\t\\t\\t\\t<head>\\n\\t\\t\\t\\t\\t<title>ssr</title>\\n\\t\\t\\t\\t</head>\\n\\t\\t\\t\\t<body>\\n\\t\\t\\t\\t\\t<div id=\"root\">' + content + '</div>\\n\\t\\t\\t\\t\\t<script>\\n\\t\\t\\t\\t\\t\\twindow.context = {\\n\\t\\t\\t\\t\\t\\t\\tstate: ' + JSON.stringify(store.getState()) + '\\n\\t\\t\\t\\t\\t\\t}\\n\\t\\t\\t\\t\\t</script>\\n\\t\\t\\t\\t\\t<script src=\\'/index.js\\'></script>\\n\\t\\t\\t\\t</body>\\n\\t\\t\\t</html>\\n\\t  ';\n};\n\n//# sourceURL=webpack:///./src/server/utils.js?");

/***/ }),

/***/ "./src/store/index.js":
/*!****************************!*\
  !*** ./src/store/index.js ***!
  \****************************/
/*! no static exports found */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
eval("\n\nObject.defineProperty(exports, \"__esModule\", {\n\tvalue: true\n});\nexports.getClientStore = exports.getStore = undefined;\n\nvar _redux = __webpack_require__(/*! redux */ \"redux\");\n\nvar _reduxThunk = __webpack_require__(/*! redux-thunk */ \"redux-thunk\");\n\nvar _reduxThunk2 = _interopRequireDefault(_reduxThunk);\n\nvar _store = __webpack_require__(/*! ../components/Header/store */ \"./src/components/Header/store/index.js\");\n\nvar _store2 = __webpack_require__(/*! ../containers/Home/store */ \"./src/containers/Home/store/index.js\");\n\nvar _store3 = __webpack_require__(/*! ../containers/Translation/store */ \"./src/containers/Translation/store/index.js\");\n\nvar _request = __webpack_require__(/*! ../client/request */ \"./src/client/request.js\");\n\nvar _request2 = _interopRequireDefault(_request);\n\nvar _request3 = __webpack_require__(/*! ../server/request */ \"./src/server/request.js\");\n\nvar _request4 = _interopRequireDefault(_request3);\n\nfunction _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }\n\n// beyond compare \n\nvar reducer = (0, _redux.combineReducers)({\n\thome: _store2.reducer,\n\theader: _store.reducer,\n\ttranslation: _store3.reducer\n});\n\nvar getStore = exports.getStore = function getStore(req) {\n\t// 改变服务器端store的内容，那么就一定要使用serverAxios\n\treturn (0, _redux.createStore)(reducer, (0, _redux.applyMiddleware)(_reduxThunk2.default.withExtraArgument((0, _request4.default)(req))));\n};\n\nvar getClientStore = exports.getClientStore = function getClientStore() {\n\tvar defaultState = window.context.state;\n\t// 改变客户端store的内容，一定要使用clientAxios\n\treturn (0, _redux.createStore)(reducer, defaultState, (0, _redux.applyMiddleware)(_reduxThunk2.default.withExtraArgument(_request2.default)));\n};\n\n//# sourceURL=webpack:///./src/store/index.js?");

/***/ }),

/***/ "axios":
/*!************************!*\
  !*** external "axios" ***!
  \************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("module.exports = require(\"axios\");\n\n//# sourceURL=webpack:///external_%22axios%22?");

/***/ }),

/***/ "express":
/*!**************************!*\
  !*** external "express" ***!
  \**************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("module.exports = require(\"express\");\n\n//# sourceURL=webpack:///external_%22express%22?");

/***/ }),

/***/ "express-http-proxy":
/*!*************************************!*\
  !*** external "express-http-proxy" ***!
  \*************************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("module.exports = require(\"express-http-proxy\");\n\n//# sourceURL=webpack:///external_%22express-http-proxy%22?");

/***/ }),

/***/ "react":
/*!************************!*\
  !*** external "react" ***!
  \************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("module.exports = require(\"react\");\n\n//# sourceURL=webpack:///external_%22react%22?");

/***/ }),

/***/ "react-dom/server":
/*!***********************************!*\
  !*** external "react-dom/server" ***!
  \***********************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("module.exports = require(\"react-dom/server\");\n\n//# sourceURL=webpack:///external_%22react-dom/server%22?");

/***/ }),

/***/ "react-redux":
/*!******************************!*\
  !*** external "react-redux" ***!
  \******************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("module.exports = require(\"react-redux\");\n\n//# sourceURL=webpack:///external_%22react-redux%22?");

/***/ }),

/***/ "react-router-config":
/*!**************************************!*\
  !*** external "react-router-config" ***!
  \**************************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("module.exports = require(\"react-router-config\");\n\n//# sourceURL=webpack:///external_%22react-router-config%22?");

/***/ }),

/***/ "react-router-dom":
/*!***********************************!*\
  !*** external "react-router-dom" ***!
  \***********************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("module.exports = require(\"react-router-dom\");\n\n//# sourceURL=webpack:///external_%22react-router-dom%22?");

/***/ }),

/***/ "redux":
/*!************************!*\
  !*** external "redux" ***!
  \************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("module.exports = require(\"redux\");\n\n//# sourceURL=webpack:///external_%22redux%22?");

/***/ }),

/***/ "redux-thunk":
/*!******************************!*\
  !*** external "redux-thunk" ***!
  \******************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("module.exports = require(\"redux-thunk\");\n\n//# sourceURL=webpack:///external_%22redux-thunk%22?");

/***/ })

/******/ });