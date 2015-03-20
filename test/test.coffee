
{ expect } = require 'chai'

keyfinder = require '../lib/index'
data      = require './fixtures/data.json'

# testa inte bara length, kolla också inneållet
# test that only one function
# test with nested array
# test with huge file
# returns false, null, undefined and 0

describe 'keyfinder module', ()->

  describe 'test', () ->

    it 'single level of an object', ->
      obj = {a: 'a', b: 'b', c: 'c'}
      results = keyfinder obj, 'c'
      expect(results).to.have.length 1

    it 'multiple levels of an object', ->
      # results = keyfinder multipleLevels, 'target'
      # assert.equal(results.length, 3)

    it 'returns an empty array when nothing is found', ->
      results = keyfinder({
        'foo': 'bar',
        'baz': {
          'biz':'boz'
        }
      }, 'doesnotexist')
      expect(results).to.have.length 0

    it 'returns an empty array when passed a non iterable object', ->
      expect(keyfinder('foo', 'target')).to.have.length 0
      expect(keyfinder(2, 'target')).to.have.length 0

    it 'returns an empty array if passed null/undefined/odd object', ->
      expect(keyfinder(null)).to.have.length 0
      expect(keyfinder(undefined)).to.have.length 0
      expect(keyfinder(false)).to.have.length 0
      expect(keyfinder(true)).to.have.length 0
      expect(keyfinder(parseInt('Break'))).to.have.length 0
