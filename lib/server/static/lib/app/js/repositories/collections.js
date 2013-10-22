(function() {
  define(["./collections/repositories"], function(Repositories) {
    var Collections;
    return Collections = (function() {
      function Collections() {}

      Collections.Repositories = Repositories;

      return Collections;

    })();
  });

}).call(this);
