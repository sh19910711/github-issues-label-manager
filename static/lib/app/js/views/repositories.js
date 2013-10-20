(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["com/backbone/backbone", "com/underscore/underscore", "app/collections/repositories"], function(Backbone, _, Repositories) {
    var RepositoriesView, _ref;
    return RepositoriesView = (function(_super) {
      __extends(RepositoriesView, _super);

      function RepositoriesView() {
        _ref = RepositoriesView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      RepositoriesView.prototype.tagName = "table";

      RepositoriesView.prototype.className = "table table-striped";

      RepositoriesView.prototype.initialize = function(options) {
        _.bindAll(this, "render");
        return this.collection.on("add", function(repo) {
          return this.$el.append("<tr data-repo-id=\"" + (repo.get('id')) + "\"><td>" + (repo.get('name')) + "</></tr>");
        }, this);
      };

      RepositoriesView.prototype.render = function() {
        return this;
      };

      return RepositoriesView;

    })(Backbone.View);
  });

}).call(this);
