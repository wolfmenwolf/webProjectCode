import React from 'react';
import Header from '../../components/Header';

const Home = () => {
	return (
		<div>
			<Header />
			<div>This is Dell Lee!</div>
			<button onClick={()=>{alert('click1')}}>
				click
			</button>
		</div>
	)
}

export default Home;
