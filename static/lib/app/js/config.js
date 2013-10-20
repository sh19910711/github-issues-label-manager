(function() {
  define([], function() {
    requirejs.config({
      paths: {
        "app/application/router": "/lib/app/js/application/router",
        "app/application": "/lib/app/js/application",
        "app/utils": "/lib/app/js/utils",
        "com/jquery/jquery": "/lib/com/jquery/js/jquery",
        "com/jquery/jquery.pjax": "/lib/com/jquery-pjax/js/jquery.pjax",
        "com/bootstrap/bootstrap": "/lib/com/bootstrap/js/bootstrap",
        "com/backbone/backbone": "/lib/com/backbone/js/backbone-min",
        "com/underscore/underscore": "/lib/com/underscore/js/underscore"
      },
      shim: {
        "com/jquery/jquery": {
          exports: "jQuery"
        },
        "com/jquery/jquery.pjax": {
          exports: "jQuery.fn.pjax",
          deps: ["com/jquery/jquery"]
        },
        "com/bootstrap/bootstrap": {
          exports: "undefined",
          deps: ["com/jquery/jquery"]
        },
        "com/backbone/backbone": {
          exports: "Backbone",
          deps: ["com/underscore/underscore"]
        },
        "com/underscore/underscore": {
          exports: "_"
        }
      }
    });
    return {};
  });

}).call(this);
