define(
  [
    "app/application/router"
    "app/utils"
  ]
  (Router)->
    class Application
      constructor: (options)->
        @router = new Router(options)
        Backbone.history.start(
          pushState: true
        )
)
