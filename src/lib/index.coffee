
isObject = require 'is-object'

find = (haystack, needle, memo = []) ->
  if needle of haystack
    memo.push haystack[needle]

  if isObject haystack
    for val in (i for i of haystack)
      find(haystack[val], needle, memo) if isObject haystack[val]

  return memo

keyfinder = (obj, predicate) ->
  find obj, predicate

module.exports = (obj, predicate) ->
  find obj, predicate

