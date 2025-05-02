const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req,res) => {
  res.send(`Hello, you have entered the application`);
});

app.get('/:type', (req, res) => {
  const type = req.params.type;
  res.send(`Hello, you queried type ${type}`);
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

