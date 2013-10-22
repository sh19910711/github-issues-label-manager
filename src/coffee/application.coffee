define(
  [
    "./application/routers"
    "./application/views"
  ]
  (Routers, Views)->
    class Application
      constructor: ()->
        @view = new Application.Views.ApplicationView()
        @router = new Application.Routers.ApplicationRouter()
      @Routers: Routers
      @Views: Views
)
