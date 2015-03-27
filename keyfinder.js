/*!
 *   keyfinder - v0.0.5
 *   Deep search for keys in objects and arrays and pluck their respective values.
 *   https://github.com/simon-johansson/keyfinder
 *   by Simon Johansson <mail@simon-johansson.com>
 *   MIT License
 */

(function(f){if(typeof exports==="object"&&typeof module!=="undefined"){module.exports=f()}else if(typeof define==="function"&&define.amd){define([],f)}else{var g;if(typeof window!=="undefined"){g=window}else if(typeof global!=="undefined"){g=global}else if(typeof self!=="undefined"){g=self}else{g=this}g.keyfinder = f()}})(function(){var define,module,exports;return (function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var arrayify, find, isArray, isFunction, isObjectOrArray;

isObjectOrArray = require('is-object');

isArray = require('is-array');

isFunction = require('is-function');


/*
when passed an object, returns an array of its keys.
when passed an array, returns an array of indexes.

arrayify({a: 'aa', b: 'bb', c: 'cc'})
-> ['a', 'b', 'c']

arrayify(['one', 'two', 'three'])
-> [1, 2, 3]
 */

arrayify = function(obj) {
  var key, results;
  results = [];
  for (key in obj) {
    results.push(key);
  }
  return results;
};

find = function(haystack, needle, memo) {
  var i, key, len, parent, ref, val;
  if (memo == null) {
    memo = [];
  }
  if (needle && isObjectOrArray(haystack)) {
    if (needle in haystack) {
      memo.push(haystack[needle]);
    }
    ref = arrayify(haystack);
    for (i = 0, len = ref.length; i < len; i++) {
      key = ref[i];
      val = haystack[key];
      if (isFunction(needle)) {
        parent = isArray(haystack) ? 'array' : 'object';
        needle(key, val, parent);
      }
      if (isObjectOrArray(val)) {
        find(val, needle, memo);
      }
    }
  }
  return memo;
};

module.exports = function(obj, key) {
  return find(obj, key);
};



},{"is-array":2,"is-function":3,"is-object":4}],2:[function(require,module,exports){

/**
 * isArray
 */

var isArray = Array.isArray;

/**
 * toString
 */

var str = Object.prototype.toString;

/**
 * Whether or not the given `val`
 * is an array.
 *
 * example:
 *
 *        isArray([]);
 *        // > true
 *        isArray(arguments);
 *        // > false
 *        isArray('');
 *        // > false
 *
 * @param {mixed} val
 * @return {bool}
 */

module.exports = isArray || function (val) {
  return !! val && '[object Array]' == str.call(val);
};

},{}],3:[function(require,module,exports){
module.exports = isFunction

var toString = Object.prototype.toString

function isFunction (fn) {
  var string = toString.call(fn)
  return string === '[object Function]' ||
    (typeof fn === 'function' && string !== '[object RegExp]') ||
    (typeof window !== 'undefined' &&
     // IE8 and below
     (fn === window.setTimeout ||
      fn === window.alert ||
      fn === window.confirm ||
      fn === window.prompt))
};

},{}],4:[function(require,module,exports){
"use strict";

module.exports = function isObject(x) {
	return typeof x === "object" && x !== null;
};

},{}]},{},[1])(1)
});