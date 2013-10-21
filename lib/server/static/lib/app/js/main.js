(function() {
  requirejs(["./config"], function() {
    return requirejs(["jquery", "com/bootstrap/bootstrap", "app/application", "app/utils"], function($, dummy1, Application, Utils) {
      return $(function() {
        var root;
        root = Utils.get_root();
        return root.application = new Application({
          side_id: "#side",
          container_id: "#container"
        });
      });
    });
  });

}).call(this);
