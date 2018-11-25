import React, { Component } from 'react';
import { connect } from 'react-redux';
import { getHomeList } from './store/actions';
import styles from './style.css';

class Home extends Component {

	componentWillMount() {
		if (this.props.staticContext) {
			this.props.staticContext.css.push(styles._getCss());
		}
	}

	getList() {
		const { list } = this.props;
		return list.map(item => <div key={item.id}>{item.title}</div>)
	}

	render() {
		return (
			<div className={styles.test}>
				{this.getList()}
				<button onClick={()=>{alert('click1')}}>
					click
				</button>
			</div>
		)
	}

	componentDidMount() {
		if (!this.props.list.length) {
			this.props.getHomeList();
		}
	}
}

const mapStateToProps = state => ({
	list: state.home.newsList
});

const mapDispatchToProps = dispatch => ({
	getHomeList() {
		dispatch(getHomeList());
	}
});

const ExportHome = connect(mapStateToProps, mapDispatchToProps)(Home);

ExportHome.loadData = (store) => {
	return store.dispatch(getHomeList())
}

export default ExportHome;
