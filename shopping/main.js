var parser = require("./tax").parser;
var readline = require('readline');
var fs = require('fs');

var rl = readline.createInterface({
  input: fs.createReadStream('expr'),
  terminal: false
});

rl.on('line', function (line) {
  console.log(parser.parse(line));
});
