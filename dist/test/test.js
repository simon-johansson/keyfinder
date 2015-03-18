(function() {
  var data, expect, keyfinder, obj;

  expect = require('chai').expect;

  keyfinder = require('../lib/index');

  data = require('./data.json');

  obj = {
    a: {
      c: 'c'
    },
    b: 'b',
    c: 'c'
  };

  describe('keyfinder module', function() {
    return describe('test', function() {
      return it("test", function() {
        return expect(keyfinder(obj, 'c')).to.eql(['c', 'c']);
      });
    });
  });

}).call(this);
