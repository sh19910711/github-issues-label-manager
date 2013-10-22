(function() {
  define(["./application/routers", "./application/views"], function(Routers, Views) {
    var Application;
    return Application = (function() {
      function Application() {
        this.view = new Application.Views.ApplicationView();
        this.router = new Application.Routers.ApplicationRouter();
      }

      Application.Routers = Routers;

      Application.Views = Views;

      return Application;

    })();
  });

}).call(this);
