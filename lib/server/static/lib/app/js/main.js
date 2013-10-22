(function() {
  requirejs(["./config"], function() {
    return requirejs(["jquery", "com/bootstrap/bootstrap", "app/common", "app/application"], function($, dummy1, Common, Application) {
      return $(function() {
        var app;
        app = {
          router: new Application.Routers.ApplicationRouter()
        };
        Backbone.fetchCache.getCacheKey = function(instance, options) {
          var res;
          res = instance.constructor.name;
          if (instance.github_user_id != null) {
            res += ':' + instance.github_user_id;
          }
          if (instance.github_repo_name != null) {
            res += ":" + instance.github_repo_name;
          }
          return res;
        };
        return Backbone.history.start({
          pushState: true
        });
      });
    });
  });

}).call(this);
