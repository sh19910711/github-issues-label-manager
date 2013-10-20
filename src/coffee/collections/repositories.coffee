define(
  [
    "com/backbone/backbone"
    "com/jquery/jquery"
    "com/underscore/underscore"
    "app/models/repository"
    "app/utils"
  ]
  (Backbone, $, _, Repository, Utils)->
    class Repositories extends Backbone.Collection
      model: Repository
      initialize: ()->
      update: ()->
        self = @
        Utils.request_api("get_new_repos").done(
          (list)->
            _(list).each (repo_info)->
              self.add new Repository(repo_info)
        )
      get_repos: ()->
        self = @
        Utils.request_api("get_repos").done(
          (list)->
            _(list).each (repo_info)->
              self.add new Repository(repo_info)
        )

)
