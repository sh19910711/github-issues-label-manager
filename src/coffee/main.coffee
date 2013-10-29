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
        "underscore"
        "jquery"
        "backbone"
        "app/application"
        "app/common"
        "com/bootstrap/bootstrap"
        "com/backbone/backbone-localstorage"
        "com/backbone/backbone-fetch-cache"
        "com/jquery/jquery.pjax"
      ]
      (
        _
        $
        Backbone
        Application
        Common
      )->
        $.ajaxPrefilter(
          (options)->
            if options.type == "POST" || options.type == "PUT" || options.type == "DELETE"
              options.data = "{}" unless options.data?
              data = JSON.parse options.data
              _(data).extend
                csrf_token: Common.Utils.get_csrf_token()
              options.data = JSON.stringify data
            options
        )
        $(
          ->
            # cache
            Backbone.fetchCache.getCacheKey = (instance, options)->
              res = instance.constructor.name
              res += ':' + instance.github_user_id if instance.github_user_id?
              res += ":" + instance.github_repo_name if instance.github_repo_name?
              res
            # app
            app =
              router: new Application.Routers.ApplicationRouter()
            # push state
            Backbone.history.start
              pushState: true
        )
    )
)
