
isObject = require 'is-object'

find = (haystack, needle, memo = []) ->
  if needle and isObject haystack
    if needle of haystack
      memo.push haystack[needle]
    for val in (i for i of haystack)
      find(haystack[val], needle, memo) if isObject haystack[val]

  return memo

keyfinder = (obj, predicate) ->
  find obj, predicate

module.exports = (obj, predicate) ->
  find obj, predicate

