define(
  [
    "underscore"
    "backbone"
    "jquery"
    "com/jquery/jquery.pjax"
    "app/utils"
    "app/views/application"
    "app/views/user_repos_page"
    "app/views/user_repo_page"
  ]
  (
    _
    Backbone
    $
    dummy1
    Utils
    ApplicationView
    UserReposPageView
    UserRepoPageView
  )->
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
        "repos/:github_user_id/:github_repo_name": "show_repo"
        "user_status": "show_user_status"
        "MIT-LICENSE.:suffix": "show_mit_license"

      show_index: ->
        @load_contents "/"

      show_about: ->
        @load_contents "/about"

      show_version: ->
        @load_contents "/version"

      show_user_status: ->
        @load_contents "/user_status"

      show_mit_license: (path)->
        @load_contents "/MIT-LICENSE.#{path}"

      show_repos: ->
        @application_view = new UserReposPageView(
          repositories:
            github_user_id: Utils.get_login_user().github_user_id
        )
        @load_contents "/repos"

      show_repo: (github_user_id, github_repo_name)->
        @application_view = new UserRepoPageView(
          issues_labels:
            github_user_id: github_user_id
            github_repo_name: github_repo_name
        )
        @load_contents "/repos/#{github_user_id}/#{github_repo_name}"

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
              root.application.view = self.application_view
              $("#application-view").append root.application.view.render().el
        )

)
