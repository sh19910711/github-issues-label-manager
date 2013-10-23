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
        @$el.append "<td>#{@model.get("name")}</td><td><button class=\"remove btn btn-danger\">remove</button></td>"
        @
      remove_label: ()=>
        @model.destroy(
          "data": JSON.stringify
            csrf_token: Common.Utils.get_csrf_token()
          dataType: "json"
          success: ->
        )
)
