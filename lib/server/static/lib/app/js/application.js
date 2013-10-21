(function() {
  define(["backbone", "com/backbone/backbone-fetch-cache", "app/application/router", "app/views/application"], function(Backbone, dummy1, Router, ApplicationView) {
    var Application;
    return Application = (function() {
      function Application(options) {
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
        this.view = new ApplicationView();
        this.router = new Router(options);
        Backbone.history.start({
          pushState: true
        });
      }

      return Application;

    })();
  });

}).call(this);
