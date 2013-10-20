define(
  [
    "com/backbone/backbone"
    "app/collections/repositories"
    "app/views/repositories"
  ]
  (Backbone, Repositories, RepositoriesView)->
    class UserReposPageView extends Backbone.View
      events:
        "click button#update_user_repos": "update_user_repos"
      initialize: (options)->
        _.bindAll this, "render"
        @repositories = new Repositories()
      update_user_repos: ()->
        @repositories.update()
      render: ()->
        this.$el.append "<button id='update_user_repos' class='btn btn-primary'>Update</button>"
        repositories_view = new RepositoriesView(
          collection: @repositories
        )
        this.$el.append repositories_view.render().el
        @
)
