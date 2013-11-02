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
        "click .remove": "event_remove"
        "click .edit": "event_edit"
        "click .edit-save": "event_edit_save"
        "click .edit-cancel": "event_edit_cancel"

      initialize: (options)->
        _.bindAll @, ["render"]
        @model.on(
          "destroy"
          =>
            @$el.remove()
        )

      render: ()=>
        @$el.css "border-left", "3px solid ##{@model.get("color") || "333"}"
        @$el.append =>
          "<div style=\"\" class=\"name label-view\">" +
          "</div>" +
          "<div class=\"controllers\">" +
          "</div>" +
          "<div class='clearfix'></div>"
        @render_normal_view()
        @$el.attr "data-label-cid", @model.cid
        @

      render_normal_view: =>
        label_name = @model.get("name").match(/([^\/]*)$/)[1]
        @$el.find(".name").empty().append =>
          "#{label_name}"
        @$el.find(".controllers").empty().append =>
          "<button class=\"edit btn btn-xs btn-warning\">edit</button> " +
          "<button class=\"remove btn btn-xs btn-danger\">remove</button>"

      render_edit_view: =>
        @$el.find(".name").empty().append "<input type='text' value='#{@model.get("name")}'>"
        @$el.find(".controllers").empty().append =>
          "<button class='edit-save btn btn-xs btn-primary'>save</button> " +
          "<button class='edit-cancel btn btn-xs'>cancel</button>"

      event_remove: ()=>
        @model.destroy(
          data: JSON.stringify
            csrf_token: Common.Utils.get_csrf_token()
          dataType: "json"
          success: ->
        )

      event_edit: ()=>
        # action -> sync
        @render_edit_view()

      event_edit_cancel: ()=>
        @render_normal_view()

      event_edit_save: ()->
        @model.save(
          {
            name: @$el.find(".name input").val()
          }
          {
            data: JSON.stringify
              csrf_token: Common.Utils.get_csrf_token()
              name: @$el.find(".name input").val()
            dataType: "json"
            success: =>
              @render_normal_view()
          }
        )
)
