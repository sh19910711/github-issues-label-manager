(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["com/backbone/backbone"], function(Backbone) {
    var Repository, _ref;
    return Repository = (function(_super) {
      __extends(Repository, _super);

      function Repository() {
        _ref = Repository.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Repository.prototype.initialize = function() {
        return console.log("@Model::Repository#initialize");
      };

      return Repository;

    })(Backbone.Model);
  });

}).call(this);
