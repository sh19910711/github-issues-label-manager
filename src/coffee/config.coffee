define(
  [
  ]
  ()->
    requirejs.config(
      paths:
        # app
        "app/main": "app/js/main"
        "app/application": "app/js/application"
        "app/common": "app/js/common"
        "app/repository": "app/js/repository"
        "app/repositories": "app/js/repositories"
        "app/page": "app/js/page"
        "app/labels": "app/js/labels"
        "app/label": "app/js/label"
        # components
        "com/jquery/jquery.pjax":             "com/jquery-pjax/js/jquery.pjax"
        "com/bootstrap/bootstrap":            "com/bootstrap/js/bootstrap"
        "com/backbone/backbone-fetch-cache":  "com/backbone-fetch-cache/js/backbone.fetch-cache"
        "com/sprintf/sprintf":                "com/sprintf/js/sprintf"
        # generals
        "jquery":       "com/jquery/js/jquery"
        "underscore":   "com/underscore/js/underscore"
        "backbone":     "com/backbone/js/backbone-min"
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
        "com/sprintf/sprintf":
          exports: "sprintf"
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
