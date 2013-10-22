_ = require "underscore"
_(global).extend
  jQuery: require "jquery"
  window:
    jQuery: require "jquery"
  underscore: require "underscore"
  backbone: require "backbone"
  documentElement: {}
  requirejs: require "requirejs"
  sinon: require "sinon"
  nock: require "nock"

requirejs.config(
  baseUrl: "/home/dev/workspace/github-issues-label-manager/lib/server/static"
  paths:
    # app
    "app/main": "lib/app/js/main"
    "app/application": "lib/app/js/application"
    "app/config": "lib/app/js/config"
    "app/common": "lib/app/js/common"
    "app/repository": "lib/app/js/repository"
    "app/repositories": "lib/app/js/repositories"
    "app/page": "lib/app/js/page"
    "app/labels": "lib/app/js/labels"
    "app/label": "lib/app/js/label"
    # components
    "com/jquery/jquery.pjax":             "lib/com/jquery-pjax/js/jquery.pjax"
    "com/bootstrap/bootstrap":            "lib/com/bootstrap/js/bootstrap"
    "com/backbone/backbone-fetch-cache":  "lib/com/backbone-fetch-cache/js/backbone.fetch-cache"
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
)

