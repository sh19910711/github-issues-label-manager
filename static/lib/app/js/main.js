(function() {
  requirejs(["./config"], function() {
    return requirejs(["com/jquery/jquery", "com/bootstrap/bootstrap"], function($) {
      return $(function() {
        return requirejs(["app/application"], function(Application) {
          var app;
          return app = new Application({
            side_id: "#side",
            container_id: "#container"
          });
        });
      });
    });
  });

}).call(this);
