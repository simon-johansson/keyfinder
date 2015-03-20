
isObject = require 'is-object'

arrayify = (obj) ->
  (key for key of obj)

find = (haystack, needle, memo = []) ->
  if needle and isObject(haystack)
    if needle of haystack
      memo.push haystack[needle]
    for key in arrayify(haystack)
      if isObject(haystack[key])
        find(haystack[key], needle, memo)
  return memo

keyfinder = (obj, predicate) ->
  find obj, predicate

module.exports = (obj, predicate) ->
  find obj, predicate
