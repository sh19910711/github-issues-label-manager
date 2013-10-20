define(
  [
    "com/backbone/backbone"
    "com/underscore/underscore"
  ]
  (Backbone, _)->
    class ApplicationView extends Backbone.View
      el: "#container"
      events:
        "click button#update_user_repos": "update_user_repos"
      update_user_repos: ()->
        console.log "@ApplicationView#update_user_repos"
      initialize: ->
        _.bindAll this, "render"
      render: ->
        $(@.el).removeClass("view").addClass("view")
        $(@.el).removeClass("application-view").addClass("application-view")
        @
)
