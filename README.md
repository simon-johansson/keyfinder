# keyfinder

[![NPM version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url] [![Coverage Status][coveralls-image]][coveralls-url] [![Dependency Status][daviddm-image]][daviddm-url]
<!-- [![Code Climate][codeclimate-image]][codeclimate-url] -->

> Deep search for keys in objects and arrays and pluck their respective values.


## Install

```sh
$ npm install --save keyfinder
```

## Usage

```js
var keyfinder = require('keyfinder');

var obj = {
  a: 'aa',
  b: 'bb',
  c: 'cc'
  d: {
    a: 'aaa'
  }
}

keyfinder(obj, 'a');
// → [ 'aa', 'aaa' ]
```

```sh
# creates a browser.js
$ npm install
$ npm run browser
```

## Tests

```sh
$ npm install
$ npm test
```


## License

MIT © [Simon Johansson]()

[npm-image]: https://badge.fury.io/js/keyfinder.svg
[npm-url]: https://npmjs.org/package/keyfinder
[travis-image]: https://travis-ci.org/simon-johansson/keyfinder.svg?branch=master
[travis-url]: https://travis-ci.org/simon-johansson/keyfinder
[coveralls-image]: https://coveralls.io/repos/simon-johansson/keyfinder/badge.svg?branch=master
[coveralls-url]: https://coveralls.io/r/simon-johansson/keyfinder?branch=master
[daviddm-image]: https://david-dm.org/simon-johansson/keyfinder.svg?theme=shields.io
[daviddm-url]: https://david-dm.org/simon-johansson/keyfinder
<!-- [codeclimate-image]: https://codeclimate.com/github/simon-johansson/keyfinder/badges/gpa.svg -->
<!-- [codeclimate-url]: https://codeclimate.com/github/simon-johansson/keyfinder -->
