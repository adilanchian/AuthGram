const https = require('https');
const FormData = require('form-data');
const albumHash = 'wE9mnsd';
const albumDeleteHash = 'foLIjQvcrdK4TiV';
const hostName = 'api.imgur.com';
const fs = require('fs');

module.exports = {
	getImages: () => {
		return new Promise((resolve, reject) => {
			let endpoint = `/3/album/${albumHash}/images`;
			let body = '';

			let request = https.request(
				{
					method: 'GET',
					hostname: hostName,
					path: endpoint,
					headers: {
						'Content-Type': 'application/json',
						Authorization: `Client-ID ${process.env.IMGUR_CLIENT_ID}`
					}
				},
				response => {
					response.on('data', chunk => {
						body += chunk;
					});

					response.on('end', () => {
						let json = JSON.parse(body);
						if (json.success) {
							console.log('Getting images successful.');
							resolve(json);
						} else {
							console.log('Getting images unsuccessful.');
							reject(json);
						}
					});
				}
			);

			request.on('error', error => {
				reject(error);
			});

			request.end();
		});
	},

	postImage: (image, username) => {
		return new Promise((resolve, reject) => {
			// Create Form Data //
			let form = new FormData();
			form.append('image', new Buffer(image));
			form.append('album', albumDeleteHash);
			form.append('title', username);

			form.submit(
				{
					protocol: 'https:',
					host: hostName,
					path: '/3/image',
					headers: { Authorization: `Client-ID ${process.env.IMGUR_CLIENT_ID}` }
				},
				(err, res) => {
					if (err) throw error;
					let body = '';

					res.on('data', chunk => {
						body += chunk;
					});

					res.on('end', () => {
						let json = JSON.parse(body);
						if (json.success) {
							console.log('Post successful.');
							resolve(json);
						} else {
							console.log('Post unsuccessful.');
							reject(json);
						}
					});
				}
			);
		});
	}
};
