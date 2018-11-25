const prerender = require('prerender');
const server = prerender({
	port: 8000
});
server.start();