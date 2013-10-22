(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["underscore", "jquery", "backbone", "app/common"], function(_, $, Backbone, Common) {
    var Repository, _ref;
    return Repository = (function(_super) {
      __extends(Repository, _super);

      function Repository() {
        _ref = Repository.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Repository.prototype.defaults = {
        full_name: "",
        id: "",
        name: ""
      };

      Repository.prototype.initialize = function(options) {
        return this;
      };

      return Repository;

    })(Backbone.Model);
  });

}).call(this);
