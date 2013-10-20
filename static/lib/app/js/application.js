(function() {
  define(["app/application/router", "app/utils"], function(Router) {
    var Application;
    return Application = (function() {
      function Application(options) {
        this.router = new Router(options);
        Backbone.history.start({
          pushState: true
        });
      }

      return Application;

    })();
  });

}).call(this);
