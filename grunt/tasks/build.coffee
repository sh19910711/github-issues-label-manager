module.exports = (grunt)->
  _ = grunt.util._
  init_config = grunt.config()

  # bower
  _(init_config).extend
    bower:
      "build":
        options:
          targetDir:      "lib/server/static/lib/com/"
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
            dest: "./lib/server/static/lib/app/js/"
            ext: ".js"
          }
        ]

  # clean
  _(init_config).extend
    clean:
      "build": [
        "lib/server/static"
      ]
      "after-build": [
        "lib/server/static/lib/app/js/*"
      ]

  # copy
  _(init_config).extend
    copy:
      "build":
        files: [
          {
            expand: true
            src: [
              "MIT-LICENSE.*"
            ]
            dest: "lib/server/static/"
            filter: "isFile"
          }
        ]
      "after-build":
        files: [
          {
            expand: true
            cwd: "tmp"
            src: [
              "main.js"
            ]
            dest: "lib/server/static/lib/app/js/"
            filter: "isFile"
          }
        ]

  # requirejs
  _(init_config).extend
    requirejs:
      "build":
        options:
          findNestedDependencies: true
          baseUrl: "lib/server/static/lib"
          name: "app/main"
          mainConfigFile: "lib/server/static/lib/app/js/config.js"
          out: "tmp/main.js"
          packages: [
            "test"
          ]
          paths:
            # components
            "jquery": "empty:"
            "backbone": "empty:"
            "underscore": "empty:"
            "bootstrap": "empty:"
            "com/jquery/jquery.pjax":             "empty:"
            "com/bootstrap/bootstrap":            "empty:"
            "com/backbone/backbone-fetch-cache":  "empty:"
            "com/sprintf/sprintf":                "empty:"
 
  # apply config
  grunt.initConfig init_config

  # load tasks
  pkg = grunt.file.readJSON 'package.json'
  for task of pkg.devDependencies when /^grunt-/.test task
    grunt.loadNpmTasks task

  # build
  grunt.registerTask(
    "build"
    [
      "clean:build"
      "bower:build"
      "coffee:build"
      "requirejs:build"
      "copy:build"
      "clean:after-build"
      "copy:after-build"
    ]
  )
