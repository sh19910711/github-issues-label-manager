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
        "com/bootstrap/bootstrap"
        "app/common"
        "app/application"
      ]
      ($, dummy1, Common, Application)->
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
