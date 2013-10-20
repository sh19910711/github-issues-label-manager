define(
  [
    "com/backbone/backbone"
    "com/underscore/underscore"
  ]
  (Backbone, _)->
    class ApplicationView extends Backbone.View
      el: "#application-view"
      initialize: ->
        _.bindAll this, "render"
      render: ->
        $(@.el).removeClass("view").addClass("view")
        $(@.el).removeClass("application-view").addClass("application-view")
        @
)
