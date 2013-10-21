(function() {
  define([], function() {
    requirejs.config({
      paths: {
        "app/application/router": "/lib/app/js/application/router",
        "app/application": "/lib/app/js/application",
        "app/views/application": "/lib/app/js/views/application",
        "app/views/repositories": "/lib/app/js/views/repositories",
        "app/views/user_repos_page": "/lib/app/js/views/user_repos_page",
        "app/views/user_repo_page": "/lib/app/js/views/user_repo_page",
        "app/views/issues_labels": "/lib/app/js/views/issues_labels",
        "app/models/repository": "/lib/app/js/models/repository",
        "app/models/issues_label": "/lib/app/js/models/issues_label",
        "app/collections/repositories": "/lib/app/js/collections/repositories",
        "app/collections/issues_labels": "/lib/app/js/collections/issues_labels",
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
