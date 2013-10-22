(function() {
  define(["./routers/application_router"], function(ApplicationRouter) {
    var Routers;
    return Routers = (function() {
      function Routers() {}

      Routers.ApplicationRouter = ApplicationRouter;

      return Routers;

    })();
  });

}).call(this);
