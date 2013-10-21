(function() {
  define(["app/application/router", "app/views/application"], function(Router, ApplicationView) {
    var Application;
    return Application = (function() {
      function Application(options) {
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
