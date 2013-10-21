define(
  [
    "com/backbone/backbone"
  ]
  (Backbone)->
    class IssuesLabel extends Backbone.Model
      defaults:
        name: ""
        color: ""
      initialize: ()->
        @
)
