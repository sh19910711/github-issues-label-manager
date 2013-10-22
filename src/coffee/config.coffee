define(
  [
  ]
  ()->
    requirejs.config(
      paths:
        # app
        "app/common":         "/lib/app/js/common"
        "app/common/utils":         "/lib/app/js/common/utils"
        "app/application":    "/lib/app/js/application"
        "app/label":          "/lib/app/js/label"
        "app/labels":         "/lib/app/js/labels"
        "app/page":           "/lib/app/js/page"
        "app/repositories":   "/lib/app/js/repositories"
        "app/repository":     "/lib/app/js/repository"
        # components
        "com/jquery/jquery.pjax":             "/lib/com/jquery-pjax/js/jquery.pjax"
        "com/bootstrap/bootstrap":            "/lib/com/bootstrap/js/bootstrap"
        "com/backbone/backbone-fetch-cache":  "/lib/com/backbone-fetch-cache/js/backbone.fetch-cache"
        # generals
        "jquery":       "/lib/com/jquery/js/jquery"
        "underscore":   "/lib/com/underscore/js/underscore"
        "backbone":     "/lib/com/backbone/js/backbone-min"
      shim:
        "com/jquery/jquery.pjax":
          exports: "jQuery.fn.pjax"
          deps: [
            "jquery"
          ]
        "com/bootstrap/bootstrap":
          exports: "undefined"
          deps: [
            "jquery"
          ]
        "com/backbone/backbone-fetch-cache":
          exports: "undefined"
          deps: [
            "backbone"
          ]
        # generals
        "backbone":
          exports: "Backbone"
          deps: [
            "underscore"
          ]
        "underscore":
          exports: "_"
    )
    {}
)
