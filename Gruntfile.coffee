module.exports = (grunt)->
  grunt.initConfig {}
  grunt.loadTasks "grunt/tasks"
  # extend here
  config = grunt.config()
  # _(config).extend(options)
  grunt.initConfig config
