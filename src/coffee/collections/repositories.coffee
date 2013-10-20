define(
  [
    "com/backbone/backbone"
    "com/models/repository"
  ]
  (Backbone, Repository)->
    class Repositories extends Backbone.Collection
      model: Repository
      initialize: ()->
        console.log "@Colleciton::Repositories#initialize"
)
