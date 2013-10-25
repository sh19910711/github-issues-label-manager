
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
    class LabelCategoryView extends Backbone.View
      initialize: ->
        console.log "LabelCategoryView#initialize", @model
        @model.on(
          "parsed"
          =>
            console.log "LabelCategoryView: after parsed render"
        )
      render: ->
        console.log "LabelCategoryView#render"
        @
)
