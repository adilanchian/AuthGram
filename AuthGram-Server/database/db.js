const MongoClient = require('mongodb').MongoClient;
let connection;

// Connect //
MongoClient.connect(process.env.MONGODB_CONNECTION, (error, db) => {
  if (error) throw error;

  connection = db;
  console.log('Connected to AuthGram DB!');
});

module.export = {};
