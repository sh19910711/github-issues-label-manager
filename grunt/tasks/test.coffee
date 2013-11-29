module.exports = (grunt)->
  _ = grunt.util._
  init_config = grunt.config()

  # mocha
  mocha_requires = [
    "coffee-script"
    "should"
    "requirejs"
    "underscore"
    "backbone"
    "jquery"
  ]
  mocha_requires.push "./spec/spec_helper.coffee" if require("fs").existsSync("./spec/spec_helper.coffee")
  _(init_config).extend
    mochaTest:
      spec:
        options:
          reporter: "spec"
          colors: false
          require: mocha_requires
          clearRequireCache: true
        src: [
          "./spec/src/coffee/**/*_spec.coffee"
        ]

  # apply config
  grunt.initConfig init_config

  # load tasks
  pkg = grunt.file.readJSON 'package.json'
  for task of pkg.devDependencies when /^grunt-/.test task
    grunt.loadNpmTasks task

  # test
  grunt.registerTask(
    "test"
    [
      "mochaTest:spec"
    ]
  )


