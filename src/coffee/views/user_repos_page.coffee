define(
  [
    "backbone"
    "app/collections/repositories"
    "app/views/repositories"
  ]
  (Backbone, Repositories, RepositoriesView)->
    class UserReposPageView extends Backbone.View
      events:
        "click button#update_user_repos": "update_user_repos"

      initialize: (options)->
        _.bindAll @, "render"
        @repositories = new Repositories(options.repositories)
        @repositories_view = new RepositoriesView(
          collection: @repositories
        )

      update_user_repos: ()->
        @repositories.fetch_new_repos()

      render: ()->
        @$el.append "<button id='update_user_repos' class='btn btn-primary'>Update Repositories</button>"
        @$el.append "<hr>"
        @$el.append @repositories_view.render().el
        @
)
