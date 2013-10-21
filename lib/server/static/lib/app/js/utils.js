(function() {
  define(["jquery", "backbone"], function($) {
    var Utils;
    return Utils = (function() {
      function Utils() {}

      Utils.get_csrf_token = function() {
        return $("meta[data-csrf-token]").data("csrf-token");
      };

      Utils.get_login_user = function() {
        var res;
        res = {};
        res.github_user_id = $("meta[data-login-user-github-user-id]").data("login-user-github-user-id");
        return res;
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
