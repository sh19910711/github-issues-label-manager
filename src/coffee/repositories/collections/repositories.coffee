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
      url: =>
        "/api/repos/#{@github_user_id}"

      initialize: (models, options)->
        @github_user_id = options["github_user_id"]
        @

)
