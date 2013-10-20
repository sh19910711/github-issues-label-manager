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
        console.log "@Colleciton::Repositories#initialize"
      update: ()->
        console.log "@Collection::Repositories#update"
        self = @
        Utils.request_api("get_new_repos").done(
          (list)->
            _(list).each (repo_info)->
              self.add new Repository(
                info: repo_info
              )
        )
)
