(function() {
  define(["./common/utils", "com/sprintf/sprintf"], function(Utils, sprintf) {
    var Common;
    return Common = (function() {
      function Common() {}

      Common.Utils = Utils;

      Common.sprintf = sprintf;

      return Common;

    })();
  });

}).call(this);
