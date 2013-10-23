define(
  [
    "underscore"
    "jquery"
    "backbone"
    "app/common"
    "app/labels"
    "com/backbone/backbone-fetch-cache"
  ]
  (
    _
    $
    Backbone
    Common
    Labels
  )->
    class UserRepoView extends Backbone.View
      tagName: "div"

      initialize: (options)->
        _.bindAll(
          @
          "render"
          "event_update_labels"
          "event_add_label"
        )
        @labels = new Labels.Collections.Labels([], options.labels)
        @labels_view = new Labels.Views.LabelsView(
          collection: @labels
        )
        @labels.fetch(
          cache: true
        )

      events: ()->
        "click button.update": "event_update_labels"
        "click .add button": "event_add_label"

      render: ()->
        @$el.append(
          "<div class=\"add form-inline\">" +
          "<div class=\"form-group\">" +
          "<label class=\"sr-only\">New Label</label>" +
          "<input id=\"new-label-name\" type=\"text\" class=\"form-control\" placeholder=\"New Label Name\">" +
          "</div>" +
          "<button type=\"submit\" class=\"btn btn-primary\">Add</button>" +
          "</div>"
        )
        @$el.append "<hr>"
        @$el.append "<h3>Issues Labels</h3>"
        @$el.append =>
          wrapper = $("<div class=\"well\"></div>")
          wrapper.append @labels_view.render().el
          wrapper
        @

      event_update_labels: ()=>
        @labels_view.collection.fetch_new_labels()

      event_add_label: ()=>
        label_name = $("input#new-label-name").val()
        @labels.add_label(
          name: label_name
          color: "#FF0000"
        )

    UserRepoView
)
