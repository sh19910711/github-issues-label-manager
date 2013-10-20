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

      Utils.request_api = function(path) {
        return $.ajax({
          url: "/api/" + path,
          type: "POST",
          dataType: "json",
          data: {
            csrf_token: this.get_csrf_token()
          }
        });
      };

      return Utils;

    })();
  });

}).call(this);
