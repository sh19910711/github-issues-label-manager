define(
  [
    "backbone"
    "com/backbone/backbone-fetch-cache"
    "app/application/router"
    "app/views/application"
  ]
  (Backbone, dummy1, Router, ApplicationView)->
    class Application
      constructor: (options)->
        # cache
        Backbone.fetchCache.getCacheKey = (instance, options)->
          res = instance.constructor.name
          res += ':' + instance.github_user_id if instance.github_user_id?
          res += ":" + instance.github_repo_name if instance.github_repo_name?
          res
        # view
        @view = new ApplicationView()
        # router
        @router = new Router(options)
        Backbone.history.start(
          pushState: true
        )
)
