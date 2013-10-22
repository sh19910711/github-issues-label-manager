(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["underscore", "jquery", "backbone", "app/common", "app/page", "com/jquery/jquery.pjax"], function(_, $, Backbone, Common, Page) {
    var ApplicationRouter, _ref;
    return ApplicationRouter = (function(_super) {
      __extends(ApplicationRouter, _super);

      function ApplicationRouter() {
        _ref = ApplicationRouter.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ApplicationRouter.prototype.initialize = function(options) {
        var _this = this;
        this.container_id = "#container_id";
        this.side_id = "#side_id";
        return $(document).on('click', 'a.pjaxable', function(e) {
          _this.navigate($(e.target).attr('href'), true);
          return false;
        });
      };

      ApplicationRouter.prototype.routes = {
        "": "show_index",
        "about": "show_about",
        "version": "show_version",
        "repos": "show_repos",
        "repos/:github_user_id/:github_repo_name": "show_repo",
        "user_status": "show_user_status",
        "MIT-LICENSE.:suffix": "show_mit_license"
      };

      ApplicationRouter.prototype.show_index = function() {
        return this.load_contents("/");
      };

      ApplicationRouter.prototype.show_about = function() {
        return this.load_contents("/about");
      };

      ApplicationRouter.prototype.show_version = function() {
        return this.load_contents("/version");
      };

      ApplicationRouter.prototype.show_user_status = function() {
        return this.load_contents("/user_status");
      };

      ApplicationRouter.prototype.show_mit_license = function(path) {
        return this.load_contents("/MIT-LICENSE." + path);
      };

      ApplicationRouter.prototype.show_repos = function() {
        this.page_view = new Page.Views.UserReposView({
          repositories: {
            github_user_id: Common.Utils.get_login_user().github_user_id
          }
        });
        return this.load_contents("/repos");
      };

      ApplicationRouter.prototype.show_repo = function(github_user_id, github_repo_name) {
        this.page_view = new Page.Views.UserRepoView({
          issues_labels: {
            github_user_id: github_user_id,
            github_repo_name: github_repo_name
          }
        });
        return this.load_contents("/repos/" + github_user_id + "/" + github_repo_name);
      };

      ApplicationRouter.prototype.load_contents = function(path) {
        var _this = this;
        console.log("@load_contents");
        return $.pjax({
          url: path,
          container: "#container"
        }).done(function() {
          $("#page-view").append(_this.page_view.el);
          if ($(_this.page_view.el).size() > 0) {
            return _this.page_view.render();
          }
        });
      };

      return ApplicationRouter;

    })(Backbone.Router);
  });

}).call(this);
