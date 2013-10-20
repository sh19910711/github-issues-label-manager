define(
  [
    "app/application/router"
    "app/views/application"
  ]
  (Router, View)->
    class Application
      constructor: (options)->
        @view = new View()
        $("#contents").append @view.render().el
        @router = new Router(options)
        Backbone.history.start(
          pushState: true
        )
)
