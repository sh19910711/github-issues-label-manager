(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["com/backbone/backbone"], function(Backbone) {
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

      IssuesLabel.prototype.initialize = function() {
        return console.log("@IssueLabel#initialize");
      };

      return IssuesLabel;

    })(Backbone.Model);
  });

}).call(this);
