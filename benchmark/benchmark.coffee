
benchmark = require 'benchmark'
bigObj = require './data/generated.json'

kvp = require 'key-value-pointer'
deepPluck = require 'deep-pluck'
stackoverflow = require './stackoverflow'
keyfinder = require '../lib/index.coffee'

suite = new benchmark.Suite()

queryAll = (obj, name) ->
  list = []
  kvp(obj).query (node) ->
    if node.key is name
      list.push node.value
    false
  list

suite
.add 'key-value-pointer', ->
  queryAll(bigObj, 'name').length
.add 'deep-pluck', ->
  deepPluck(bigObj, 'name').length
.add 'http://stackoverflow.com/a/15643382/1113977', ->
  stackoverflow(bigObj, 'name').length
.add 'keyfinder', ->
  keyfinder(bigObj, 'name').length
.on 'cycle', (event) ->
  console.log String(event.target), event.target.times.period * 1000, ' ms'
.on 'complete', ->
  console.log 'Fastest is ' + this.filter('fastest').pluck('name')
.run()
