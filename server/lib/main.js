const express = require('express');
const app = express();
const cors = require('cors');
const uuid = require('uuid').v4;
const expressAsyncHandler = require('express-async-handler');
const Api = require('./routers');
const colors = require('colors')


app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));
app.use(Api)

module.exports = function main() {
    app.listen(3000, () => {
        console.log('Server is running on port 3000'.yellow);
    })
}
