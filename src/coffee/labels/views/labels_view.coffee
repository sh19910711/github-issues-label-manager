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
          (target)=>
            console.log "labels view collection sync"
            if target instanceof @collection.constructor
              target.each (label)=>
                $("[data-label-cid=\"#{label.cid}\"]").removeClass "syncing"
            if target instanceof @collection.model
              @add_label_view target
              $("[data-label-cid=\"#{target.cid}\"]").removeClass "syncing"
          @
        )
        @collection.on(
          "add"
          (label)=>
            @add_label_view label
            $("[data-label-cid=\"#{label.cid}\"]").addClass "syncing"
          @
        )

      has_label_view: (label)->
        if label.cid
          if @$el.find("[data-label-cid=\"#{label.cid}\"]").length
            return true
        false

      find_label_view: (label)->
        if label.cid?
          ret = @$el.find("[data-label-cid=\"#{label.cid}\"]")
          if ret.length
            return ret
        false

      add_label_view: (label)->
        unless @has_label_view label
          label_view = new Label.Views.LabelView(
            model: label
          )
          @$el.append label_view.render().$el

      render: ()->
        @collection.each @add_label_view, @
        @
)
