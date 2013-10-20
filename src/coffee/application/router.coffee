define(
  [
    "com/underscore/underscore"
    "com/backbone/backbone"
    "com/jquery/jquery"
    "com/jquery/jquery.pjax"
  ]
  (_, Backbone, $, dummy1)->
    class Router extends Backbone.Router
      initialize: (options)->
        @container_id = options.container_id
        @side_id = options.side_id
        self = @
        $(document).on(
          'click',
          'a.pjaxable',
          ()->
            self.navigate $(@).attr('href'), true
            return false
        )

      routes:
        "": "show_index"
        "about": "show_about"
        "version": "show_version"
        "repos": "show_repos"

      show_index: ->
        @load_contents "/"

      show_about: ->
        @load_contents "/about"

      show_version: ->
        @load_contents "/version"

      show_repos: ->
        @load_contents "/repos"

      load_contents: (path)->
        $.pjax(
          url: path
          container: @container_id
        ).done(
          ->
        )

)
