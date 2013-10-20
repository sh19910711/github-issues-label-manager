(function() {
  requirejs(["./config"], function() {
    return requirejs(["com/jquery/jquery", "com/bootstrap/bootstrap"], function($) {
      return $(function() {
        return requirejs(["app/application", "app/utils"], function(Application, Utils) {
          var root;
          root = Utils.get_root();
          return root.application = new Application({
            side_id: "#side",
            container_id: "#container"
          });
        });
      });
    });
  });

}).call(this);
