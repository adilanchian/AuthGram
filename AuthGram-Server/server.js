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
	let result = await imgur.getImages().catch(json => {
		res.send({ data: { error: json.data.error }, status: json.status });
	});

	res.send({ data: result.data, status: result.status });
});

server.post(`${baseApiPath}/image`, async (req, res) => {
	console.log('Posting image...');
	/*
		{
			user: String,
			image: Base64 String
		}
	*/
	let imgString = req.body.image.file_data;
	let result = await imgur.postImage(imgString).catch(json => {
		console.log(json.data.error);
		// Fail //
		res.send({
			data: { error: json.data.error },
			status: json.status
		});
	});

	// Success //
	res.send({
		data: result.data,
		status: result.status
	});
});

server.listen(8000, () => {
	console.log('AuthGram server port 8000 listening!');
});
