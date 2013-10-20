define(
  [
    "app/application/router"
    "app/views/application"
  ]
  (Router, ApplicationView)->
    class Application
      constructor: (options)->
        # view
        @view = new ApplicationView()
        # router
        @router = new Router(options)
        Backbone.history.start(
          pushState: true
        )
)
