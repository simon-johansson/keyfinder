(function() {
  var find, isObject, keyfinder;

  isObject = require('is-object');

  find = function(haystack, needle, memo) {
    var i, val, _i, _len, _ref;
    if (memo == null) {
      memo = [];
    }
    if (needle in haystack) {
      memo.push(haystack[needle]);
    }
    if (isObject(haystack)) {
      _ref = (function() {
        var _results;
        _results = [];
        for (i in haystack) {
          _results.push(i);
        }
        return _results;
      })();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        val = _ref[_i];
        if (isObject(haystack[val])) {
          find(haystack[val], needle, memo);
        }
      }
    }
    return memo;
  };

  keyfinder = function(obj, predicate) {
    return find(obj, predicate);
  };

  module.exports = function(obj, predicate) {
    return find(obj, predicate);
  };

}).call(this);
