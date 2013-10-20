define(
  [
    "com/backbone/backbone"
  ]
  (Backbone)->
    class Repository extends Backbone.Model
      initialize: ()->
        console.log "@Model::Repository#initialize"
)
