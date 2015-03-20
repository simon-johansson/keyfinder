
isObject   = require 'is-object'
isFunction = require 'is-function'

###
when passed an object, returns an array of its keys.
when passed an array, returns an array of its indexes.

arrayify({a: 'aa', b: 'bb', c: 'cc'})
-> ['a', 'b', 'c']

arrayify(['one', 'two', 'three'])
-> [1, 2, 3]
###
arrayify = (obj) ->
  (key for key of obj)

find = (haystack, needle, memo = []) ->

  # isObject returns true from both objects and arrays
  if needle and isObject(haystack)

    if needle of haystack
      memo.push haystack[needle]

    for key in arrayify(haystack)
      val = haystack[key]

      if isFunction(needle)
        needle(key, val)

      if isObject(val)
        find(val, needle, memo)

  return memo

module.exports = (obj, key) ->
  find obj, key
