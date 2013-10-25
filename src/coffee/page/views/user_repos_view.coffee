define(
  [
    "underscore"
    "jquery"
    "backbone"
    "app/common"
    "app/repositories"
  ]
  (
    _
    $
    Backbone
    Common
    Repositories
  )->
    class UserReposView extends Backbone.View
      tagName: "div"

      events:
        "click button#update_user_repos": "update_user_repos"

      initialize: (options)->
        _.bindAll @, "render"
        @repositories = new Repositories.Collections.Repositories([], options.repositories)
        @repositories_view = new Repositories.Views.RepositoriesView(
          collection: @repositories
        )

      update_user_repos: ()=>
        @repositories.fetch
          data:
            csrf_token: Common.Utils.get_csrf_token()

      render: ()=>
        @$el.append(
          "<button id='update_user_repos' class='btn btn-primary'>" +
          "Update Repositories" +
          "</button>"
        )
        @$el.append "<hr>"
        @$el.append =>
          wrapper = $("<div class=\"well\"></div>")
          wrapper.append @repositories_view.render().el
          wrapper
        @

    UserReposView
)
