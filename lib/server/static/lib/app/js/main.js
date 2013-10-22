(function() {
  requirejs(["./config"], function() {
    return requirejs(["jquery", "com/bootstrap/bootstrap", "app/application", "app/common"], function($, dummy1, Application, Common) {
      return $(function() {
        var root;
        root = Common.Utils.get_root();
        return root.application = new Application();
      });
    });
  });

}).call(this);
