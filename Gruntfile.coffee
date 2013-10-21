module.exports = (grunt)->
  _ = grunt.util._
  init_config = {}

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

  # este-watch
  _(init_config).extend
    esteWatch:
      options:
        dirs: [
          './lib/server/static/lib/app/**/'
          './src/coffee/**/'
        ]
        livereload:
          enabled: true
          port: process.env['LIVERELOAD_PORT']
          extensions: ['js', 'css']
      'coffee': (path) ->
        if path.match(/^src\/coffee\//)
          files = [
            expand: true
            cwd: "./src/coffee"
            src: path.match(/^src\/coffee\/(.*)/)[1]
            dest: "./lib/server/static/lib/app/js/"
            ext: ".js"
          ]
          grunt.config ['coffee', 'update', 'files'], files
          ['coffee:update']
        else
          []

  # clean
  _(init_config).extend
    clean:
      "build": [
        "static"
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
            filter: 'isFile'
          }
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
      "copy:build"
    ]
  )

  grunt.registerTask(
    "watch"
    [
      "esteWatch"
    ]
  )


