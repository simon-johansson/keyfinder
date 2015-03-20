
{ expect } = require 'chai'

keyfinder = require '../lib/index'
data      = require './fixtures/data.json'

# deep nested key
# qqnested array
# test with huge file
# inception, key within a key

describe 'keyfinder module\n', ->

  describe 'keyfinder(<haystack>, <needle = "string">)', ->

    it 'find key in single level object', ->
      obj =
        a: 'aa'
        b: 'bb'
        c: 'cc'

      results = keyfinder obj, 'c'
      expect(results).to.have.length 1
      expect(results).to.have.eql ['cc']

    it 'find nested key in multi level object', ->
      obj =
        a: 'aa'
        b:
          c: 'cc'
        d: 'dd'

      results = keyfinder obj, 'c'
      expect(results).to.have.length 1
      expect(results).to.have.eql ['cc']

    it 'find multiple matching keys in nested object', ->
      obj =
        a: 'aa'
        b:
          a: 'aaa'
        c:
          a: 'aaaa'

      results = keyfinder obj, 'a'
      expect(results).to.have.length 3
      expect(results).to.have.eql ['aa', 'aaa', 'aaaa']

    it "find keys when top level is an array", ->
      arr = [
        {a: 'aa', b: 'bb'}
        {a: 'aa', b: 'bb', c: 'cc'}
      ]

      results = keyfinder arr, 'a'
      expect(results).to.have.length 2
      expect(results).to.have.eql ['aa', 'aa']

    it 'return the value of the matching key even if its falsy', ->
      obj =
        a:
          x: undefined
        b:
          x: null
        c:
          x: 0
        d:
          x: []

      results = keyfinder obj, 'x'
      expect(results).to.have.length 4
      expect(results).to.eql [undefined, null, 0, []]

    it 'return an empty array if no needle in haystack', ->
      obj =
        a: 'aa'
        b: 'bb'
        c: 'cc'

      results = keyfinder obj, 'z'
      expect(results).to.be.an "array"
      expect(results).to.have.length 0

    it 'return an empty array when haystack is not an object or array\n', ->
      expect(keyfinder('string', 'needle')).to.have.length 0
      expect(keyfinder(666, 'needle')).to.have.length 0
      expect(keyfinder(null, 'needle')).to.have.length 0
      expect(keyfinder(undefined, 'needle')).to.have.length 0
      expect(keyfinder(false, 'needle')).to.have.length 0
      expect(keyfinder(true, 'needle')).to.have.length 0


  describe 'keyfinder(<haystack>, <clb = function>)', ->

    it 'pass callback function instead of string as needle', ->
      expect(-> keyfinder {a: 'aa'}, ->).to.not.throw /error/
      results = keyfinder {a: 'aa'}, ->
      expect(results).to.be.an "array"
      expect(results).to.have.length 0

    it 'callback should receive each key/val pair in heystack', ->
      obj =
        a: 'aa'
        b: 'bb'
        c: 'cc'

      fn = (obj) ->
        list = []
        keyfinder obj, (key, val) ->
          obj = {}
          obj[key] = val
          list.push obj
        list

      results = fn obj
      expect(results).to.have.length 3
      expect(results).to.eql [ { a: 'aa' }, { b: 'bb' }, { c: 'cc' } ]
