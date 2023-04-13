var express = require('express');
var http = require('http');
var app = express();
var server = http.createServer(app).listen(80);

app.get('/login', function (req, res) {
  res.sendfile("javascript.html");
});

app.get('/inner', function (req, res) {
  res.sendfile("inner.html");
});

app.get('/array', function (req, res) {
  res.sendfile("arr.html");
});

app.get('/369', function (req, res) {
  res.sendfile("369.html");
});


app.get('/login1', function (req, res) {
  res.sendfile("javascript1.html");
});

app.get('/inner1', function (req, res) {
  res.sendfile("inner1.html");
});

app.get('/array1', function (req, res) {
  res.sendfile("arr1.html");
});

app.get('/3691', function (req, res) {
  res.sendfile("3691.html");
});
