(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["underscore", "backbone", "jquery", "com/jquery/jquery.pjax", "app/utils", "app/views/application", "app/views/user_repos_page", "app/views/user_repo_page"], function(_, Backbone, $, dummy1, Utils, ApplicationView, UserReposPageView, UserRepoPageView) {
    var Router, _ref;
    return Router = (function(_super) {
      __extends(Router, _super);

      function Router() {
        _ref = Router.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Router.prototype.initialize = function(options) {
        var self;
        this.application_view = ApplicationView;
        this.container_id = options.container_id;
        this.side_id = options.side_id;
        self = this;
        return $(document).on('click', 'a.pjaxable', function() {
          self.navigate($(this).attr('href'), true);
          return false;
        });
      };

      Router.prototype.routes = {
        "": "show_index",
        "about": "show_about",
        "version": "show_version",
        "repos": "show_repos",
        "repos/:github_user_id/:github_repo_name": "show_repo",
        "user_status": "show_user_status",
        "MIT-LICENSE.:suffix": "show_mit_license"
      };

      Router.prototype.show_index = function() {
        return this.load_contents("/");
      };

      Router.prototype.show_about = function() {
        return this.load_contents("/about");
      };

      Router.prototype.show_version = function() {
        return this.load_contents("/version");
      };

      Router.prototype.show_user_status = function() {
        return this.load_contents("/user_status");
      };

      Router.prototype.show_mit_license = function(path) {
        return this.load_contents("/MIT-LICENSE." + path);
      };

      Router.prototype.show_repos = function() {
        this.application_view = new UserReposPageView({
          repositories: {
            github_user_id: Utils.get_login_user().github_user_id
          }
        });
        return this.load_contents("/repos");
      };

      Router.prototype.show_repo = function(github_user_id, github_repo_name) {
        this.application_view = new UserRepoPageView({
          issues_labels: {
            github_user_id: github_user_id,
            github_repo_name: github_repo_name
          }
        });
        return this.load_contents("/repos/" + github_user_id + "/" + github_repo_name);
      };

      Router.prototype.load_contents = function(path) {
        var self;
        self = this;
        return $.pjax({
          url: path,
          container: this.container_id
        }).done(function() {
          var root;
          if ($("#application-view").size() > 0) {
            root = Utils.get_root();
            root.application.view = self.application_view;
            return $("#application-view").append(root.application.view.render().el);
          }
        });
      };

      return Router;

    })(Backbone.Router);
  });

}).call(this);
