define(
  [
    "com/backbone/backbone"
    "app/collections/issues_labels"
    "app/views/issues_labels"
    "app/utils"
  ]
  (Backbone, IssuesLabels, IssuesLabelsView, Utils)->
    class UserRepoPageView extends Backbone.View
      initialize: (options)->
        _.bindAll @, ["render"]
        @issues_labels = new IssuesLabels(options.issues_labels)
        @issues_labels_view = new IssuesLabelsView(
          collection: @issues_labels
        )

      events: ()->
        "click button.update": "event_update_labels"

      render: ()->
        @.$el.empty()
        @.$el.append "<button class='update btn btn-primary'>Update Labels</button>"
        @.$el.append "<hr>"
        @.$el.append "<h3>Issues Labels</h3>"
        @.$el.append @issues_labels_view.render().el
        @

      "event_update_labels": ()->
        @issues_labels_view.collection.fetch_new_labels()

)
