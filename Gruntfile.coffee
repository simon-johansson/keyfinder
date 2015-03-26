'use strict'

module.exports = (grunt)->

  # load all grunt tasks
  require('load-grunt-tasks')(grunt)

  _ = grunt.util._
  path = require 'path'

  # Project configuration.
  grunt.initConfig

    pkg: grunt.file.readJSON('package.json')

    coffeelint:
      gruntfile:
        src: '<%= watch.gruntfile.files %>'
      lib:
        src: '<%= watch.lib.files %>'
      test:
        src: '<%= watch.test.files %>'
      options:
        configFile: 'coffeelint.json'

    coffee:
      lib:
        expand: true
        cwd: 'lib/'
        src: ['**/*.coffee']
        dest: 'dist/lib'
        ext: '.js'
      test:
        expand: true
        cwd: 'test/'
        src: ['**/*.coffee']
        dest: 'dist/test/'
        ext: '.js'

    mochaTest:
      test:
        options:
          require: 'coffee-script/register'
          reporter: 'spec'
        src: [
          'test/**/*.coffee'
        ]

    copy:
      dist:
        files: [
          expand: true,
          cwd: 'test',
          dest: 'dist/test/',
          src: [
            '**/*.json'
          ]
        ]

    watch:
      options:
        spawn: false
      gruntfile:
        files: 'Gruntfile.coffee'
        tasks: ['coffeelint:gruntfile']
      lib:
        files: ['lib/**/*.coffee']
        tasks: ['coffeelint:lib', 'coffee:lib', 'mochaTest']
      test:
        files: ['test/**/*.coffee']
        tasks: ['coffeelint:test', 'mochaTest']

    clean: ['dist/']

    browserify:
      dist:
        files:
          'keyfinder.js': ['lib/index.coffee']
        options:
          transform: ['coffeeify']
          browserifyOptions:
            standalone: 'keyfinder'

    release:
      options:
        additionalFiles: ['bower.json']
        beforeRelease: ['browserify']

  # tasks.
  grunt.registerTask 'compile', [
    'coffeelint'
    'coffee'
    'copy'
  ]

  grunt.registerTask 'test', [
    'mochaTest'
  ]

  grunt.registerTask 'default', [
    'clean'
    'compile'
    'test'
  ]

