(function() {
  define(["./application/routers", "./application/views"], function(Routers, Views) {
    var Application;
    return Application = (function() {
      function Application() {}

      Application.Routers = Routers;

      Application.Views = Views;

      return Application;

    })();
  });

}).call(this);
