define(
  [
    "backbone"
    "app/labels"
  ]
  (Backbone, Labels)->
    class UserRepoPageView extends Backbone.View
      initialize: (options)->
        _.bindAll @, ["render"]
        @issues_labels = new IssuesLabels(options.issues_labels)
        @issues_labels_view = new IssuesLabelsView(
          collection: @issues_labels
        )

      events: ()->
        "click button.update": "event_update_labels"
        "click .add button": "event_add_label"

      render: ()->
        @$el.empty()
        # @$el.append "<div><button class='update btn btn-primary'>Update Labels</button></div>"
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
        @$el.append @issues_labels_view.render().el
        @

      event_update_labels: ()->
        @issues_labels_view.collection.fetch_new_labels()

      event_add_label: ()->
        label_name = $("input#new-label-name").val()
        @issues_labels.add_label.call(
          @issues_labels
          name: label_name
          color: "FF0000"
        )

)
