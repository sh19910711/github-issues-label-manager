(function() {
  define(["./repository/models"], function(Models) {
    var Repository;
    return Repository = (function() {
      function Repository() {}

      Repository.Models = Models;

      return Repository;

    })();
  });

}).call(this);
