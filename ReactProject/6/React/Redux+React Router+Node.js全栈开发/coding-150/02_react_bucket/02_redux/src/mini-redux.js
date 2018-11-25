
import isPlainObject from 'lodash/isPlainObject'

function bindActionCreator(creator, dispatch){
  return (...args)=>dispatch(creator(...args))
}
export function bindActionCreators(creators, dispatch){

  // var bound = {}
  // Object.keys(creators).forEach(key=>{
  //   var ctr = creators[key]
  //   bound[key] = bindActionCreator(ctr, dispatch)
  // })
  // return bound

  return Object.keys(creators).reduce((ret,item)=>{
    var ctr = creators[item]
    ret[item] = bindActionCreator(ctr, dispatch)
    return ret
  },{})
}
export function createStore(reducer, enhancer){

  if (enhancer) {
    return enhancer(createStore)(reducer)
  }

  let currentState = {}
  let currentListeners = []

  function getState(){
    return currentState
  }
  function subscribe(listener){
    currentListeners.push(listener)
  }
  function dispatch(action){
    if (!isPlainObject(action)) {
      console.log('action 必须是对象')
    }

    currentState = reducer(currentState, action)
    currentListeners.forEach(v=>v())
    return action
  }

  // createStore 时候初始化，type命名唯一
  dispatch({ type: '@IMOOC/REDUX' })
  return {
    name:'你大爷',
    dispatch,
    subscribe,
    getState
  }
}

export function applyMiddleware(middleware) {
  return (createStore) => (...args) => {
    const store = createStore(...args)
    let dispatch = store.dispatch
    // let chain = []

    const middlewareAPI = {
      getState: store.getState,
      dispatch: (...args) => dispatch(...args)
    }
    dispatch = middleware(middlewareAPI)(store.dispatch)
    // chain = middlewares.map(middleware => middleware(middlewareAPI))
    // dispatch = compose(...chain)(store.dispatch)

    return {
      ...store,
      dispatch
    }
  }
}


// function createThunkMiddleware(extraArgument) {
//   return ({ dispatch, getState }) => next => action => {
//     if (typeof action === 'function') {
//       return action(dispatch, getState, extraArgument);
//     }

//     return next(action);
//   };
// }

// const thunk = createThunkMiddleware();
// thunk.withExtraArgument = createThunkMiddleware;

// export default thunk;


export function compose(...funcs) {
  if (funcs.length === 0) {
    return arg => arg
  }

  if (funcs.length === 1) {
    return funcs[0]
  }

  return funcs.reduce((a, b) => (...args) => a(b(...args)))
}

