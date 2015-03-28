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
          '<%= pkg.name %>.js': ['lib/index.coffee']
        options:
          transform: ['coffeeify']
          browserifyOptions:
            standalone: '<%= pkg.name %>'

    uglify:
      client:
        files: '<%= pkg.name %>.min.js': ['<%= pkg.name %>.js']
      node:
        options:
          mangle: false
          compress: false
          beautify: true
        files: 'dist/lib/index.js': ['dist/lib/index.js']

    usebanner:
      options:
        position: 'top'
        banner: """
         /*!
          *   <%= pkg.name %> - v<%= pkg.version %>
          *   <%= pkg.description %>
          *   <%= pkg.homepage %>
          *   by <%= pkg.author.name %> <<%= pkg.author.email %>>
          *   <%= pkg.license %> License
          */

        """
        linebreak: true
      files:
        src: ['<%= pkg.name %>.js', '<%= pkg.name %>.min.js', 'dist/lib/index.js']

    bump:
      options:
        files: ['package.json', 'bower.json']
        updateConfigs: ['pkg']
        commitFiles: ['package.json', 'bower.json', '<%= pkg.name %>.js', '<%= pkg.name %>.min.js']
        pushTo: 'origin'

    shell:
      publish:
        command: "npm publish"

  grunt.registerTask "release", "Release a new version, push it and publish it", (target) ->
    target = "patch" unless target
    grunt.task.run "bump-only:#{target}", "compile", "bump-commit", "shell:publish"

  # tasks.
  grunt.registerTask 'compile', [
    'clean'
    'coffee'
    'copy'
    'browserify'
    'uglify'
    'usebanner'
  ]

  grunt.registerTask 'test', [
    'coffeelint'
    'mochaTest'
  ]

  grunt.registerTask 'default', [
    'test'
    'compile'
  ]

