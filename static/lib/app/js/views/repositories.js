(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["com/backbone/backbone"], function(Backbone) {
    var RepositoriesView, _ref;
    return RepositoriesView = (function(_super) {
      __extends(RepositoriesView, _super);

      function RepositoriesView() {
        _ref = RepositoriesView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      RepositoriesView.prototype.initialize = function() {
        return console.log("@View::RepositoriesView#initialize");
      };

      return RepositoriesView;

    })(Backbone.Colleciton);
  });

}).call(this);
