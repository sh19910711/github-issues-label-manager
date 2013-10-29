_ = require "underscore"

_(global).extend
  jQuery: require "jquery"
  window:
    jQuery: require "jquery"
  _: require "underscore"
  backbone: require "backbone"
  documentElement: {}
  requirejs: require "requirejs"
  sinon: require "sinon"
  nock: require "nock"

requirejs.config(
  baseUrl: "/home/dev/workspace/github-issues-label-manager"
  paths:
    # app
    "app/main": "tmp/lib/app/js/main"
    "app/application": "tmp/lib/app/js/application"
    "app/config": "tmp/lib/app/js/config"
    "app/common": "tmp/lib/app/js/common"
    "app/repository": "tmp/lib/app/js/repository"
    "app/repositories": "tmp/lib/app/js/repositories"
    "app/page": "tmp/lib/app/js/page"
    "app/labels": "tmp/lib/app/js/labels"
    "app/label": "tmp/lib/app/js/label"
    "app/label_category": "tmp/lib/app/js/label_category"
    # components
    "com/jquery/jquery.pjax":             "lib/server/static/lib/com/jquery-pjax/js/jquery.pjax"
    "com/bootstrap/bootstrap":            "lib/server/static/lib/com/bootstrap/js/bootstrap"
    "com/backbone/backbone-fetch-cache":  "lib/server/static/lib/com/backbone-fetch-cache/js/backbone.fetch-cache"
    "com/sprintf/sprintf":                "lib/server/static/lib/com/sprintf/js/sprintf"
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
      exports: "window.sprintf"
)

