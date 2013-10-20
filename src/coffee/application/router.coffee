define(
  [
    "com/underscore/underscore"
    "com/backbone/backbone"
    "com/jquery/jquery"
    "com/jquery/jquery.pjax"
    "app/utils"
    "app/views/application"
    "app/views/user_repos_page"
  ]
  (_, Backbone, $, dummy1, Utils, ApplicationView, UserReposPageView)->
    class Router extends Backbone.Router
      initialize: (options)->
        @application_view = ApplicationView
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
        @application_view = UserReposPageView
        @load_contents "/repos"

      load_contents: (path)->
        self = @
        $.pjax(
          url: path
          container: @container_id
        ).done(
          ->
            # set application view
            if $("#application-view").size() > 0
              root = Utils.get_root()
              root.application.view = new self.application_view()
              $("#application-view").append root.application.view.render().el
        )

)
