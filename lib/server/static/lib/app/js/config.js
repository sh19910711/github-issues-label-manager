(function() {
  define([], function() {
    requirejs.config({
      paths: {
        "app/main": "/lib/app/js/main",
        "app/application": "/lib/app/js/application",
        "app/config": "/lib/app/js/config",
        "app/common": "/lib/app/js/common",
        "app/repository": "/lib/app/js/repository",
        "app/repositories": "/lib/app/js/repositories",
        "app/page": "/lib/app/js/page",
        "app/labels": "/lib/app/js/labels",
        "app/label": "/lib/app/js/label",
        "com/jquery/jquery.pjax": "/lib/com/jquery-pjax/js/jquery.pjax",
        "com/bootstrap/bootstrap": "/lib/com/bootstrap/js/bootstrap",
        "com/backbone/backbone-fetch-cache": "/lib/com/backbone-fetch-cache/js/backbone.fetch-cache",
        "com/sprintf/sprintf": "/lib/com/sprintf/js/sprintf",
        "jquery": "/lib/com/jquery/js/jquery",
        "underscore": "/lib/com/underscore/js/underscore",
        "backbone": "/lib/com/backbone/js/backbone-min"
      },
      shim: {
        "com/jquery/jquery.pjax": {
          exports: "jQuery.fn.pjax",
          deps: ["jquery"]
        },
        "com/bootstrap/bootstrap": {
          exports: "undefined",
          deps: ["jquery"]
        },
        "com/backbone/backbone-fetch-cache": {
          exports: "undefined",
          deps: ["backbone"]
        },
        "com/sprintf/sprintf": {
          exports: "sprintf"
        },
        "backbone": {
          exports: "Backbone",
          deps: ["underscore"]
        },
        "underscore": {
          exports: "_"
        }
      }
    });
    return {};
  });

}).call(this);
