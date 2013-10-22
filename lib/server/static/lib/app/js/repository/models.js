(function() {
  define(["./models/repository"], function(Repository) {
    var Models;
    return Models = (function() {
      function Models() {}

      Models.Repository = Repository;

      return Models;

    })();
  });

}).call(this);
