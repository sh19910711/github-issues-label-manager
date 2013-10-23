define(
  [
    "underscore"
    "jquery"
    "backbone"
    "app/common"
    "app/repository"
    "com/backbone/backbone-fetch-cache"
  ]
  (
    _
    $
    Backbone
    Common
    Repository
  )->
    class Repositories extends Backbone.Collection
      model: Repository.Models.Repository

      initialize: (models, options)->
        @github_user_id = options["github_user_id"]
        @

      fetch_repos: ()->
        self = @
        @fetch(
          cache: true
          type: "get"
          data:
            csrf_token: Common.Utils.get_csrf_token()
          url: "/api/repos/#{@github_user_id}"
          dataType: "json"
        ).done(
          (repos)->
            _(repos).each(
              (repo)->
                self.add repo
            )
            self.trigger "fetch-end"
        )

      fetch_new_repos: ()->
        self = @
        @fetch(
          type: "put"
          url: "/api/repos/#{@github_user_id}"
          data:
            csrf_token: Common.Utils.get_csrf_token()
          dataType: "json"
        ).done(
          (repos)->
            _(repos).each(
              (repo)->
                self.add repo
            )
            self.trigger "fetch-end"
        )

)
