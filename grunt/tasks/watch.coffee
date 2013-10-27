module.exports = (grunt)->
  _ = grunt.util._
  init_config = grunt.config()

  livereload_port = process.env['GILM_LIVERELOAD_PORT'] || process.env['LIVERELOAD_PORT']

  livereload_options =
    enabled: true
    port: livereload_port
    extensions: ['js', 'css']

  unless livereload_port?
    _(livereload_options).extend
      enabled: false

  # este-watch
  _(init_config).extend
    esteWatch:
      options:
        dirs: [
          './lib/server/static/lib/app/**/'
          './src/coffee/**/'
          './spec/src/coffee/**/'
          './src/scss/**/'
        ]
        livereload: livereload_options

      'scss': (path) =>
        ["compass:build"]

      'coffee': (path) =>
        if path.match(/^spec\/src\/coffee\//)
          ['test']
        else if path.match(/^src\/coffee\//)
          files = [
            expand: true
            cwd: "./src/coffee"
            src: path.match(/^src\/coffee\/(.*)/)[1]
            dest: "./tmp/lib/app/js/"
            ext: ".js"
          ]
          grunt.config ['coffee', 'update', 'files'], files
          [
            'coffee:update'
            'requirejs:build'
            'copy:after-build'
            'touch:build'
          ]
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
