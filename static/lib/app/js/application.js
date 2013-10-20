(function() {
  define(["app/application/router", "app/views/application"], function(Router, View) {
    var Application;
    return Application = (function() {
      function Application(options) {
        this.view = new View();
        $("#contents").append(this.view.render().el);
        this.router = new Router(options);
        Backbone.history.start({
          pushState: true
        });
      }

      return Application;

    })();
  });

}).call(this);
