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
    class Label extends Backbone.Model
      defaults:
        name: ""
        color: ""
      initialize: (options)->
        @
)
