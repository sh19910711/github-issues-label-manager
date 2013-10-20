define(
  [
    "com/backbone/backbone"
  ]
  (Backbone)->
    class Repository extends Backbone.Model
      defaults:
        full_name: ""
        id: ""
        name: ""
      initialize: (options)->
)
