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
      tagName: "div"
      className: "label-view"

      events:
        "click .remove": "event_remove_label"
        "click .edit": "event_edit_label"
        "click .edit-save": "event_edit_save_label"

      initialize: (options)->
        console.log "LabelView#initialize: ", options
        _.bindAll @, ["render"]
        @model.on(
          "destroy"
          =>
            @$el.remove()
        )

      render: ()=>
        console.log "LabelView#render"
        label_name = @model.get("name").match(/([^\/]*)$/)[1]
        @$el.css "border-left", "3px solid ##{@model.get("color") || "333"}"
        @$el.append =>
          "<div class=\"name\" style=\"\" class=\"label-view\">" +
          "#{label_name}" +
          "</div>" +
          "<div class=\"controllers\">" +
          "<button class=\"edit btn btn-xs btn-warning\">edit</button> " +
          "<button class=\"remove btn btn-xs btn-danger\">remove</button>" +
          "</div>" + 
          "<div class='clearfix'></div>"
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
