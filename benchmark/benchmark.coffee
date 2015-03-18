_ = require 'lodash'
benchmark = require 'benchmark'
bigObj = require './data/generated.json'

deepPluck = require 'deep-pluck'
keyfinder = require '../src/index.coffee'

suite = new benchmark.Suite()

suite
.add 'deep-pluck', ->
  deepPluck(bigObj, 'name').length
.add 'keyfinder', ->
  keyfinder(bigObj, 'name').length
.on 'cycle', (event) ->
  console.log String(event.target), event.target.times.period * 1000, ' ms'
.on 'complete', ->
  console.log 'Fastest is ' + this.filter('fastest').pluck('name')
.run()
