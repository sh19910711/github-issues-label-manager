define(
  [
    "./application/routers"
    "./application/views"
  ]
  (Routers, Views)->
    class Application
      @Routers: Routers
      @Views: Views
)
