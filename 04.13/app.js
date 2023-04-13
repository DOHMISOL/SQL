var express = require('express');
var http = require('http');
var app = express();
var server = http.createServer(app).listen(80);

app.get('/arr', function (req, res) {
  res.sendfile("arr.html");
});

app.get('/radio', function (req, res) {
  res.sendfile("radio.html");
});

app.get('/radio2', function (req, res) {
  res.sendfile("radio2.html");
});
