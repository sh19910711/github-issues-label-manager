define(
  [
    "underscore"
    "jquery"
    "backbone"
    "app/common"
  ]
  (
    _
    $
    Backbone
    Common
  )->
    class Repository extends Backbone.Model
      defaults: ->
        full_name: ""
        id: ""
        name: ""
      initialize: (options)->
        @
)
