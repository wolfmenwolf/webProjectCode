import express from 'express';
import Home from './containers/Home';
import React from 'react';
import { renderToString } from 'react-dom/server';

const app = express();
app.use(express.static('public'));

const content = renderToString(<Home />);

app.get('/', function (req, res) {
  res.send(`
		<html>
			<head>
				<title>ssr</title>
			</head>
			<body>
				${content}
				<script src='/index.js'></script>
			</body>
		</html>
  `);
});

var server = app.listen(3000);