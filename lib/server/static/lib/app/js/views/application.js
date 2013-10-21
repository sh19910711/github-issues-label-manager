(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "underscore"], function(Backbone, _) {
    var ApplicationView, _ref;
    return ApplicationView = (function(_super) {
      __extends(ApplicationView, _super);

      function ApplicationView() {
        _ref = ApplicationView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      ApplicationView.prototype.el = "#application-view";

      ApplicationView.prototype.initialize = function() {
        return _.bindAll(this, "render");
      };

      ApplicationView.prototype.render = function() {
        $(this.el).removeClass("view").addClass("view");
        $(this.el).removeClass("application-view").addClass("application-view");
        return this;
      };

      return ApplicationView;

    })(Backbone.View);
  });

}).call(this);
