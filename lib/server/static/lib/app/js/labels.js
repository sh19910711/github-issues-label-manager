(function() {
  define(["./labels/collections", "./labels/views"], function(Collections, Views) {
    var Labels;
    return Labels = (function() {
      function Labels() {}

      Labels.Collections = Collections;

      Labels.Views = Views;

      return Labels;

    })();
  });

}).call(this);
