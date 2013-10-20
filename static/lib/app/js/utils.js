(function() {
  define(["com/jquery/jquery", "com/backbone/backbone"], function($) {
    var Utils;
    return Utils = (function() {
      function Utils() {}

      Utils.get_csrf_token = function() {
        return $("meta[data-csrf-token]").data("csrf-token");
      };

      Utils.get_root = function() {
        return window;
      };

      return Utils;

    })();
  });

}).call(this);
