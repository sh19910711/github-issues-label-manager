define(
  [
    "underscore"
    "backbone"
    "jquery"
    "com/jquery/jquery.pjax"
    "app/common"
    "app/page"
  ]
  (
    _
    Backbone
    $
    dummy1
    Page
  )->
    class ApplicationRouter extends Backbone.Router
      initialize: (options)->
        @container_id = "#container_id"
        @side_id = "#side_id"
        $(document).on(
          'click',
          'a.pjaxable',
          ()->
            Backbone.Router.navigate $(@).attr('href'), true
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
        @application_view = new Page.Views.UserReposView(
          repositories:
            github_user_id: Common.Utils.get_login_user().github_user_id
        )
        @load_contents "/repos"

      show_repo: (github_user_id, github_repo_name)->
        @application_view = new Page.Views.UserRepoView(
          issues_labels:
            github_user_id: github_user_id
            github_repo_name: github_repo_name
        )
        @load_contents "/repos/#{github_user_id}/#{github_repo_name}"

      load_contents: (path)->
        $.pjax(
          url: path
          container: @container_id
        ).done(
          =>
            # set application view
            console.log @application_view.el
            if $(@application_view.el).size() > 0
              root = Common.Utils.get_root()
              root.application.view = self.application_view
              $(@application_view.el).append root.application.view.render().el
        )

)
