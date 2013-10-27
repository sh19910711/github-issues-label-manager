requirejs.config(
  baseUrl: "/lib"
)
requirejs(
  [
    "app/js/config"
  ]
  ->
    requirejs(
      [
        "jquery"
        "backbone"
        "app/application"
        "com/bootstrap/bootstrap"
        "com/backbone/backbone-localstorage"
        "com/backbone/backbone-fetch-cache"
        "com/jquery/jquery.pjax"
      ]
      (
        $
        Backbone
        Application
      )->
        $(
          ->
            # app
            app =
              router: new Application.Routers.ApplicationRouter()

            # cache
            Backbone.fetchCache.getCacheKey = (instance, options)->
              res = instance.constructor.name
              res += ':' + instance.github_user_id if instance.github_user_id?
              res += ":" + instance.github_repo_name if instance.github_repo_name?
              res

            # push state
            Backbone.history.start(
              pushState: true
            )
        )
    )
)
