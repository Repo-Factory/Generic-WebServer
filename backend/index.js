/*
 * PROGRAM ENTRY POINT
 */

const express     = require('express');
var cors          = require("cors");
const bodyParser  = require('body-parser');

const setupExpress = (app) => {
  app.use(cors());
  app.use(express.static('public')); //serves HTML file from public folder for front end
  app.use(bodyParser.json());
  app.use(bodyParser.urlencoded({extended: true,}))
}

const setupEndpoints = (app) => {
  app.get('/');
}

const setupServer = (app, port) => {
  app.listen(port, () => {
    console.log(`App running on port ${port}.`);
  })
}

const main = () => {
  const port = 5500;
  const app = express();
  setupExpress(app);
  setupEndpoints(app);
  setupServer(app, port)
}

if (require.main === module) {
  main();
}
