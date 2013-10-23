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
      className: "table table-striped table-hover"

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
            @add_label_view label
          @
        )

      add_label_view: (label)->
        unless !! @$el.find("##{label.get_view_id()}").length
          label_view = new Label.Views.LabelView(
            model: label
          )
          @$el.append label_view.render().$el

      render: ()->
        @collection.each @add_label_view, @
        @
)
