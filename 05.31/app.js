var express = require('express');
var http = require('http');
var app = express();
var server = http.createServer(app).listen(80);

var mysql      = require('mysql');
var connection = mysql.createConnection({
  host     : 'localhost',
  user     : 'root',
  password : '0000',
  database : 'web'
});

let bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({limit: '50mb', extended: false}));
app.use(bodyParser.json({limit: '50mb'}));

app.get('/', function (req, res) {
  res.sendfile("chart.html");
});
app.get('/getNaver', function (req, res) {
  let price = getPrice();
  res.send(price);

let options = {
   url:'https://finance.naver.com/item/main.naver?code=336260',
   method: 'GET'
 }
