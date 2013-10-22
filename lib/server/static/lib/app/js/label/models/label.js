(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["underscore", "jquery", "backbone", "app/common"], function(_, $, Backbone, Common) {
    var IssuesLabel, _ref;
    return IssuesLabel = (function(_super) {
      __extends(IssuesLabel, _super);

      function IssuesLabel() {
        _ref = IssuesLabel.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      IssuesLabel.prototype.defaults = {
        name: "",
        color: ""
      };

      IssuesLabel.prototype.initialize = function(options) {
        return this;
      };

      return IssuesLabel;

    })(Backbone.Model);
  });

}).call(this);
