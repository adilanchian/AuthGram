require('dotenv').config();
const express = require('express');
const server = express();
const bodyParser = require('body-parser');
const fs = require('fs');
const imgur = require('./Imgur/imgur');

//-- Properties --//
const baseApiPath = '/api/v1';

// Routes //
server.use(bodyParser.json({ limit: '16mb', extended: true }));
server.get('/', (req, res) => {
	console.log('Root Route Hit.');
	res.send('Welcome to AuthGram!');
});

server.get(`${baseApiPath}/images`, async (req, res) => {
	console.log('Fetching all images...');

	// Send request to get images from Imgur album //
	try {
		let result = await imgur.getImages();
		res.send({ data: result.data, status: result.status });
	} catch (error) {
		console.error(error);
		res.send({ data: { error: error }, status: 500 });
	}
});

server.post(`${baseApiPath}/image`, async (req, res) => {
	console.log('Posting image...');

	let imgString = req.body.image.file_data;
	let username = req.body.image.username;

	try {
		let result = await imgur.postImage(imgString, username);
		res.send({
			data: result.data,
			status: result.status
		});
	} catch (error) {
		console.error(error);
		res.send({
			data: { error: error },
			status: 500
		});
	}
});

server.listen(8000, () => {
	console.log('AuthGram server port 8000 listening!');
});
