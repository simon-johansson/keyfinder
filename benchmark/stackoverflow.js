var _ = require('lodash');

// http://stackoverflow.com/a/15643382/1113977
function findNested(obj, key, memo) {
  var i, proto = Object.prototype,
      ts = proto.toString;
  ('[object Array]' !== ts.call(memo)) && (memo = []);
  for (i in obj) {
    if (proto.hasOwnProperty.call(obj, i)) {
      if (i === key) {
        memo.push(obj[i]);
      } else if ('[object Array]' === ts.call(obj[i]) || '[object Object]' === ts.call(obj[i])) {
        findNested(obj[i], key, memo);
      }
    }
  }
  return memo;
}

module.exports = findNested;
