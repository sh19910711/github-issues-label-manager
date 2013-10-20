module.exports = (grunt)->
  _ = grunt.util._
  init_config = {}

  # bower
  _(init_config).extend
    bower:
      "build":
        options:
          targetDir:      "static/lib/com/"
          layout:         "byComponent"
          install:        true
          verbose:        true
          cleanTargetDir: false
          cleanBowerDir:  true

  # coffee
  _(init_config).extend
    coffee:
      "build":
        files: [
          {
            expand: true
            cwd: "./src/coffee/"
            src: "**/*.coffee"
            dest: "./static/lib/app/js/"
            ext: ".js"
          }
        ]

  # clean
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
      "coffee:build"
    ]
  )


