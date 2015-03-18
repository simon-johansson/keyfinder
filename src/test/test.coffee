
{ expect } = require 'chai'

keyfinder = require '../lib/index'
data      = require './data.json'

obj =
  a:
    c: 'c'
  b: 'b'
  c: 'c'

describe 'keyfinder module', ()->

  describe 'test', () ->
    it "test", ->
      expect(keyfinder(obj, 'c')).to.eql ['c', 'c']
