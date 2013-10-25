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
        "click .remove": "event_remove_label"
        "click .edit": "event_edit_label"
        "click .edit-save": "event_edit_save_label"

      initialize: ()->
        _.bindAll @, ["render"]
        @model.on(
          "sync"
          =>
            @model.set "id", @model.get("name")
            console.log @model
        )
        @model.on(
          "destroy"
          =>
            @$el.remove()
        )

      render: ()=>
        @$el.append =>
          "<td class=\"label-name\" style=\"border-left: 3px solid ##{@model.get("color") || "333"}\" class=\"label-view\">" +
          "#{@model.get("name")}" +
          "</td>" +
          "<td class=\"text-right\">" +
          "<button class=\"edit btn btn-xs btn-warning\">edit</button> " +
          "<button class=\"remove btn btn-xs btn-danger\">remove</button>" +
          "</td>"
        @$el.attr "data-label-cid", @model.cid
        @

      event_remove_label: ()=>
        @model.destroy(
          data: JSON.stringify
            csrf_token: Common.Utils.get_csrf_token()
          dataType: "json"
          success: ->
        )

      event_edit_label: ()=>
        # action -> sync
        @$el.find("td.label-name").empty().append "<div class='form-inline'><div class='form-group'><input type='text' class='form-control' value='#{@model.get("name")}'></div><button class='btn btn-primary edit-save'>save</button></div>"

      event_edit_save_label: ()=>
        @model.save(
          {
            name: @$el.find(".label-name input").val()
          }
          {
            data: JSON.stringify
              csrf_token: Common.Utils.get_csrf_token()
              name: @$el.find(".label-name input").val()
            dataType: "json"
            success: =>
              @$el.find("td.label-name").empty().append "#{@model.get("name")}"
          }
        )
)
