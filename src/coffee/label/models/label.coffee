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
    class IssuesLabel extends Backbone.Model
      defaults:
        name: ""
        color: ""
      initialize: (options)->
        @
)
