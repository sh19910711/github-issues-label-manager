module.exports = (grunt)->
  _ = grunt.util._
  init_config = grunt.config()

  # este-watch
  _(init_config).extend
    esteWatch:
      options:
        dirs: [
          './lib/server/static/lib/app/**/'
          './src/coffee/**/'
          './spec/src/coffee/**/'
        ]
        livereload:
          enabled: true
          port: process.env['GILM_LIVERELOAD_PORT'] || process.env['LIVERELOAD_PORT']
          extensions: ['js', 'css']
      'coffee': (path) =>
        if path.match(/^spec\/src\/coffee\//)
          ['test']
        else if path.match(/^src\/coffee\//)
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

  # apply config
  grunt.initConfig init_config

  # load tasks
  pkg = grunt.file.readJSON 'package.json'
  for task of pkg.devDependencies when /^grunt-/.test task
    grunt.loadNpmTasks task

  # watch
  grunt.registerTask(
    "watch"
    [
      "esteWatch"
    ]
  )
