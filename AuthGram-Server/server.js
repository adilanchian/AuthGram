require('dotenv').config();
const express = require('express');
const server = express();

// Database //
const db = require('./database/db');

// Routes //
server.get('/', (req, res) => {
  console.log('Root Route Hit.');
  res.send('Welcome to AuthGram!');
});

server.listen(8000, () => {
  console.log('AuthGram server port 8000 listening!');
});
