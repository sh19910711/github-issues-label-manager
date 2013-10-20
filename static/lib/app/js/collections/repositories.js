(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["com/backbone/backbone", "com/models/repository"], function(Backbone, Repository) {
    var Repositories, _ref;
    return Repositories = (function(_super) {
      __extends(Repositories, _super);

      function Repositories() {
        _ref = Repositories.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Repositories.prototype.model = Repository;

      Repositories.prototype.initialize = function() {
        return console.log("@Colleciton::Repositories#initialize");
      };

      return Repositories;

    })(Backbone.Collection);
  });

}).call(this);
