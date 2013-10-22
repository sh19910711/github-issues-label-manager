(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "underscore"], function(Backbone, _) {
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
        _.bindAll(this, ["render"]);
        this.collection.on("fetch-end", function() {
          return this.render();
        }, this);
        this.collection.fetch_repos();
        return this;
      };

      RepositoriesView.prototype.render = function() {
        this.$el.empty();
        this.collection.each(function(repo) {
          return this.$el.append(("<tr data-repo-id=\"" + (repo.get('id')) + "\"><td>") + ("<a class='pjaxable' href=\"/repos/" + (repo.get('full_name')) + "\">") + ("" + (repo.get('name'))) + "</a></></tr>");
        }, this);
        return this;
      };

      return RepositoriesView;

    })(Backbone.View);
  });

}).call(this);
