module.exports = (grunt)->
  _ = grunt.util._
  init_config = {}

  _(init_config).extend
    bower:
      "build":
        options:
          targetDir:      "static/lib/"
          layout:         "byComponent"
          install:        true
          verbose:        true
          cleanTargetDir: false
          cleanBowerDir:  true

  _(init_config).extend
    clean:
      "build": [
        "static"
      ]

  grunt.initConfig init_config
  
  # load npm tasks
  pkg = grunt.file.readJSON 'package.json'
  for task of pkg.devDependencies when /^grunt-/.test task
    grunt.loadNpmTasks task

  grunt.registerTask(
    "build"
    [
      "clean:build"
      "bower:build"
    ]
  )


