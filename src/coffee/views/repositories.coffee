define(
  [
    "com/backbone/backbone"
  ]
  (Backbone)->
    class RepositoriesView extends Backbone.Colleciton
      initialize: ()->
        console.log "@View::RepositoriesView#initialize"
)
