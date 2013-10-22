(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["underscore", "jquery", "backbone", "app/common", "app/repositories"], function(_, $, Backbone, Common, Repositories) {
    var UserReposView, _ref;
    UserReposView = (function(_super) {
      __extends(UserReposView, _super);

      function UserReposView() {
        this.render = __bind(this.render, this);
        this.update_user_repos = __bind(this.update_user_repos, this);
        _ref = UserReposView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      UserReposView.prototype.id = "page-view";

      UserReposView.prototype.events = {
        "click button#update_user_repos": "update_user_repos"
      };

      UserReposView.prototype.initialize = function(options) {
        _.bindAll(this, "render");
        this.repositories = new Repositories.Collections.Repositories(options.repositories);
        return this.repositories_view = new Repositories.Views.RepositoriesView({
          collection: this.repositories
        });
      };

      UserReposView.prototype.update_user_repos = function() {
        return this.repositories.fetch_new_repos();
      };

      UserReposView.prototype.render = function() {
        this.$el.append("<button id='update_user_repos' class='btn btn-primary'>" + "Update Repositories" + "</button>");
        this.$el.append("<hr>");
        this.$el.append(this.repositories_view.render().el);
        return this;
      };

      return UserReposView;

    })(Backbone.View);
    return UserReposView;
  });

}).call(this);
