
import React from 'react'
import PropTypes from 'prop-types'
import {bindActionCreators} from './mini-redux'
export let  connect = (mapStateToProps=state=>state, mapDispatchToProps={}) => (WrappedComponent) => {
  class Connect extends React.Component {
    static contextTypes = {
      store: PropTypes.object
    }
    constructor (props) {
      super(props)
      this.state = {
        props: {}
      }
    }

    componentDidMount () {
      const { store } = this.context
      store.subscribe(() => this.update())
      this.update()
    }

    update () {
      const { store } = this.context
      const stateProps = mapStateToProps(store.getState())
      const dispatchProps = bindActionCreators(mapDispatchToProps, store.dispatch)

      this.setState({
        props: {
          ...stateProps,
          ...dispatchProps,
          ...this.props
        }
      })
    }

    render () {
      return <WrappedComponent {...this.state.props} />
    }
  }
  return Connect
}

export class Provider extends React.Component {
  static childContextTypes = {
    store: PropTypes.object
  }
  getChildContext() {
    // 将store其声明为 context 的属性之一
    // 所有子组件，都可以通过 context 拿到全局的 store
    return { store: this.store }
  }
  constructor(props, context) {
    super(props, context)
    // 接收 redux 的 store 作为 props
    this.store = props.store
  }
  render() {
    return this.props.children
  }
}
