const https = require('https');
const albumHash = 'Q4bhF2P';
const basePath = 'api.imgur.com';

module.exports = {
	getImages: () => {
		return new Promise((resolve, reject) => {
			let endpoint = `/3/album/${albumHash}/images`;
			let images = '';

			let request = https.request(
				{
					method: 'GET',
					hostname: basePath,
					path: endpoint,
					headers: {
						'Content-Type': 'application/json',
						Authorization: `Client-ID ${process.env.IMGUR_CLIENT_ID}`
					}
				},
				response => {
					response.on('data', imageList => {
						images += imageList;
					});

					response.on('end', () => {
						resolve(JSON.parse(images));
					});
				}
			);

			request.on('error', error => {
				reject(error);
			});

			request.end();
		});
	}
};
