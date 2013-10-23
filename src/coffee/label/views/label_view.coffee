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
    class LabelView extends Backbone.View
      tagName: "tr"
      events:
        "click .remove": "remove_label"
      initialize: ()->
        _.bindAll @, ["render"]
        @model.on(
          "destroy"
          =>
            @$el.remove()
        )
      render: ()=>
        @$el.append "<td style=\"border-left: 3px solid ##{@model.get("color") || "333"}\" class=\"label-view\">#{@model.get("name")}</td><td class=\"text-right\"><button class=\"remove btn btn-xs btn-danger\">remove</button></td>"
        @$el.attr "id", @model.get_view_id()
        @
      remove_label: ()=>
        @model.destroy(
          "data": JSON.stringify
            csrf_token: Common.Utils.get_csrf_token()
          dataType: "json"
          success: ->
        )
)
