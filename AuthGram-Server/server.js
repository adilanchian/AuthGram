require('dotenv').config();
const express = require('express');
const server = express();
const bodyParser = require('body-parser');
const fs = require('fs');
const baseApiPath = '/api/v1';

server.use(bodyParser.raw());

// Routes //
server.get('/', (req, res) => {
	console.log('Root Route Hit.');
	res.send('Welcome to AuthGram!');
});

server.get(`${baseApiPath}/images`, async (req, res) => {
	console.log('Fetching all images...');

	res.send({ images: images });
});

server.post(`${baseApiPath}/image/upload`, async (req, res) => {
	console.log('Posting all images...');

	// Write body stream to file //
	let filename = req.headers['x-filename'];
	res.sendStatus(200);
});

server.listen(8000, () => {
	console.log('AuthGram server port 8000 listening!');
});
