(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["com/underscore/underscore", "com/backbone/backbone", "com/jquery/jquery", "com/jquery/jquery.pjax", "app/utils", "app/views/application", "app/views/user_repos_page"], function(_, Backbone, $, dummy1, Utils, ApplicationView, UserReposPageView) {
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
        "repos": "show_repos"
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

      Router.prototype.show_repos = function() {
        this.application_view = UserReposPageView;
        return this.load_contents("/repos");
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
            root.application.view = new self.application_view();
            return $("#application-view").append(root.application.view.render().el);
          }
        });
      };

      return Router;

    })(Backbone.Router);
  });

}).call(this);
