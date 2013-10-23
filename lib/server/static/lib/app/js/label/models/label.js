(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["underscore", "jquery", "backbone", "app/common"], function(_, $, Backbone, Common) {
    var Label, _ref;
    return Label = (function(_super) {
      __extends(Label, _super);

      function Label() {
        this.get_color = __bind(this.get_color, this);
        this.set_color = __bind(this.set_color, this);
        this.resolve_color_code = __bind(this.resolve_color_code, this);
        _ref = Label.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Label.prototype.defaults = {
        name: "",
        color: {
          r: 0,
          g: 0,
          b: 0
        }
      };

      Label.prototype.initialize = function(options) {
        var _this = this;
        this.on("change", function() {
          return _this.set("color", _this.resolve_color_code(_this.get("color")));
        });
        return this;
      };

      Label.prototype.validate = function() {
        var color1;
        color1 = this.get("color");
        if (!(color1 && _(color1).has("r") && _(color1).has("g") && _(color1).has("b"))) {
          return "color must have r, g, b props";
        }
      };

      Label.prototype.resolve_color_code = function(color_code) {
        var matches;
        if (typeof color_code === "string") {
          color_code = $.trim(color_code);
          if (!!color_code.match(/^#[0-9A-F]{6}$/)) {
            matches = color_code.match(/#([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})/);
            return {
              r: parseInt(matches[1], 16),
              g: parseInt(matches[2], 16),
              b: parseInt(matches[3], 16)
            };
          } else if (!!color_code.match(/^[0-9A-F]{6}$/)) {
            matches = color_code.match(/([0-9A-F]{2})([0-9A-F]{2})([0-9A-F]{2})/);
            return {
              r: parseInt(matches[1], 16),
              g: parseInt(matches[2], 16),
              b: parseInt(matches[3], 16)
            };
          } else if (!!color_code.match(/^#[0-9A-F]{3}$/)) {
            matches = color_code.match(/#([0-9A-F]{1})([0-9A-F]{1})([0-9A-F]{1})/);
            return {
              r: parseInt(matches[1] + matches[1], 16),
              g: parseInt(matches[2] + matches[2], 16),
              b: parseInt(matches[3] + matches[3], 16)
            };
          } else if (!!color_code.match(/^[0-9A-F]{3}$/)) {
            matches = color_code.match(/([0-9A-F]{1})([0-9A-F]{1})([0-9A-F]{1})/);
            return {
              r: parseInt(matches[1] + matches[1], 16),
              g: parseInt(matches[2] + matches[2], 16),
              b: parseInt(matches[3] + matches[3], 16)
            };
          }
        } else {
          return color_code;
        }
      };

      Label.prototype.set_color = function(color_code) {
        return this.set("color", color_code);
      };

      Label.prototype.get_color = function() {
        var bb, color1, gg, rr;
        color1 = this.get("color");
        rr = Common.sprintf("%02X", color1.r);
        gg = Common.sprintf("%02X", color1.g);
        bb = Common.sprintf("%02X", color1.b);
        return "#" + rr + gg + bb;
      };

      return Label;

    })(Backbone.Model);
  });

}).call(this);
