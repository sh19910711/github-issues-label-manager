define(
  [
    "underscore"
    "jquery"
    "backbone"
    "app/common"
    "app/label"
  ]
  (
    _
    $
    Backbone
    Common
    Label
  )->
    class LabelsView extends Backbone.View
      tagName: "table"
      className: "table table-striped"

      initialize: (options)->
        _.bindAll @, ["render"]
        @collection.on(
          "sync"
          (label)=>
            # after sync
          @
        )
        @collection.on(
          "add"
          (label)=>
            @add_label_view label if label instanceof Label.Models.Label
          @
        )

      add_label_view: (label)->
        label_view = new Label.Views.LabelView(
          model: label
        )
        @$el.append label_view.render().$el

      render: ()->
        @collection.each @add_label_view, @
        @
)
