
{ expect } = require 'chai'

keyfinder = require '../lib/index'

describe 'keyfinder module\n', ->

  describe 'keyfinder(object/array, [predicate = "string"])', ->

    it 'find key in single level object', ->
      obj =
        a: 'aa'
        b: 'bb'
        c: 'cc'

      results = keyfinder obj, 'c'
      expect(results).to.have.length 1
      expect(results).to.have.eql ['cc']

    it 'find key nested in multi level object', ->
      obj =
        a: 'aa'
        b:
          c: 'cc'
        d: 'dd'

      results = keyfinder obj, 'c'
      expect(results).to.have.length 1
      expect(results).to.have.eql ['cc']

    it 'find deeply nested key in multi level object', ->
      obj = require './fixtures/nested.json'

      results = keyfinder obj, 'key'
      expect(results).to.have.length 1
      expect(results).to.have.eql ['value']

    it 'find deeply nested key in multi level array', ->
      obj = require './fixtures/nested_array.json'

      results = keyfinder obj, 'inception'
      expect(results).to.have.length 2
      expect(results).to.have.eql [false, true]

    it 'find multiple matching keys', ->
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

    it 'return multiple matches even if they are nested within each other', ->
      obj =
        a:
          a: [
            { a: 'aa' }
          ]
          b: 'bb'

      results = keyfinder obj, 'a'
      expect(results).to.have.length 3
      expect(results).to.eql [ { a: [{ a: 'aa' }], b: 'bb' }, [ { a: 'aa' } ], 'aa' ]

    it 'return an empty array if no predicate is passed', ->
      results = keyfinder {a: 'aa'}
      expect(results).to.be.an "array"
      expect(results).to.have.length 0

    it 'return an empty array if no match is found', ->
      obj =
        a: 'aa'
        b: 'bb'
        c: 'cc'

      results = keyfinder obj, 'z'
      expect(results).to.be.an "array"
      expect(results).to.have.length 0

    it 'return an empty array when haystack is not an object or array\n', ->
      expect(keyfinder('string', 'predicate')).to.have.length 0
      expect(keyfinder(666, 'predicate')).to.have.length 0
      expect(keyfinder(null, 'predicate')).to.have.length 0
      expect(keyfinder(undefined, 'predicate')).to.have.length 0
      expect(keyfinder(false, 'predicate')).to.have.length 0
      expect(keyfinder(true, 'predicate')).to.have.length 0


  describe 'keyfinder(object/array, [callback = "function"])', ->

    it 'should be able to pass function instead of string as second argument', ->
      expect(-> keyfinder {a: 'aa'}, ->).to.not.throw /error/

    it 'callback should receive each key/val pair in heystack', ->
      obj =
        a: 'aa'
        b: 'bb'
        c: 'cc'

      fn = (obj) ->
        list = []
        keyfinder obj, (key, val, parent) ->
          obj =
            key: key
            val: val
            parent: parent
          list.push obj
        list

      results = fn obj
      expect(results).to.have.length 3
      expect(results).to.eql [
        { key: 'a', val: 'aa', parent: 'object' },
        { key: 'b', val: 'bb', parent: 'object' },
        { key: 'c', val: 'cc', parent: 'object' },
      ]
