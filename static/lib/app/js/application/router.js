(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["com/underscore/underscore", "com/backbone/backbone", "com/jquery/jquery", "com/jquery/jquery.pjax"], function(_, Backbone, $, dummy1) {
    var Router, _ref;
    return Router = (function(_super) {
      __extends(Router, _super);

      function Router() {
        _ref = Router.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Router.prototype.initialize = function(options) {
        var self;
        this.container_id = options.container_id;
        this.side_id = options.side_id;
        self = this;
        return $(this.side_id).on('click', 'a.pjaxable', function() {
          self.navigate($(this).attr('href'), true);
          return false;
        });
      };

      Router.prototype.routes = {
        "": "show_index",
        "about": "show_about"
      };

      Router.prototype.show_index = function() {
        return this.load_contents("/");
      };

      Router.prototype.show_about = function() {
        return this.load_contents("/about");
      };

      Router.prototype.load_contents = function(path) {
        return $.pjax({
          url: path,
          container: this.container_id
        }).done(function() {});
      };

      return Router;

    })(Backbone.Router);
  });

}).call(this);
