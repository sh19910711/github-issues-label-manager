(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "app/repositories"], function(Backbone, Repositories) {
    var UserReposPageView, _ref;
    return UserReposPageView = (function(_super) {
      __extends(UserReposPageView, _super);

      function UserReposPageView() {
        _ref = UserReposPageView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      UserReposPageView.prototype.events = {
        "click button#update_user_repos": "update_user_repos"
      };

      UserReposPageView.prototype.initialize = function(options) {
        _.bindAll(this, "render");
        this.repositories = new Repositories(options.repositories);
        return this.repositories_view = new RepositoriesView({
          collection: this.repositories
        });
      };

      UserReposPageView.prototype.update_user_repos = function() {
        return this.repositories.fetch_new_repos();
      };

      UserReposPageView.prototype.render = function() {
        this.$el.append("<button id='update_user_repos' class='btn btn-primary'>Update Repositories</button>");
        this.$el.append("<hr>");
        this.$el.append(this.repositories_view.render().el);
        return this;
      };

      return UserReposPageView;

    })(Backbone.View);
  });

}).call(this);
