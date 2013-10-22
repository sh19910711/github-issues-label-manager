(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["underscore", "jquery", "backbone", "app/common"], function(_, $, Backbone, Common) {
    var Label, _ref;
    return Label = (function(_super) {
      __extends(Label, _super);

      function Label() {
        _ref = Label.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Label.prototype.defaults = {
        name: "",
        color: ""
      };

      Label.prototype.initialize = function(options) {
        return this;
      };

      return Label;

    })(Backbone.Model);
  });

}).call(this);
