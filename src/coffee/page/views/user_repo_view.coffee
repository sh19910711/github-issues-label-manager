define(
  [
    "underscore"
    "jquery"
    "backbone"
    "app/common"
    "app/labels"
    "app/label_category"
    "com/backbone/backbone-fetch-cache"
  ]
  (
    _
    $
    Backbone
    Common
    Labels
    LabelCategory
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
        @label_category = new LabelCategory.Models.LabelCategory(
          name: "root"
          childrens: {}
          flag_leaf: false
        )
        @label_category_view = new LabelCategory.Views.LabelCategoryView(
          model: @label_category
        )
        @labels.on(
          "sync"
          (target)=>
            @label_category.parse_labels @labels
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
          wrapper.append @label_category_view.el
          wrapper
        @

      event_update_labels: ()->
        @labels_view.collection.fetch_new_labels()

      event_add_label: ()->
        label_name = $("input#new-label-name").val()
        @labels.add_label(
          name: label_name
          color: "#FF0000"
        )

    UserRepoView
)
