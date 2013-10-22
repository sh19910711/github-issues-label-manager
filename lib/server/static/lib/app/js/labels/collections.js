(function() {
  define(["./collections/labels"], function(Labels) {
    var Collections;
    return Collections = (function() {
      function Collections() {}

      Collections.Labels = Labels;

      return Collections;

    })();
  });

}).call(this);
