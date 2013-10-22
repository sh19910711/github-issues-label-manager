(function() {
  define(["./repositories/collections", "./repositories/views"], function(Collections, Views) {
    var Repositories;
    return Repositories = (function() {
      function Repositories() {}

      Repositories.Collections = Collections;

      Repositories.Views = Views;

      return Repositories;

    })();
  });

}).call(this);
