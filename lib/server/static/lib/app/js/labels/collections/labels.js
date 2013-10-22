(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["underscore", "jquery", "backbone", "app/common", "app/label", "com/backbone/backbone-fetch-cache"], function(_, $, Backbone, Common, Label) {
    var Labels, _ref;
    Labels = (function(_super) {
      __extends(Labels, _super);

      function Labels() {
        this.fetch_labels = __bind(this.fetch_labels, this);
        this.add_label = __bind(this.add_label, this);
        _ref = Labels.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Labels.prototype.model = Label.Models.Label;

      Labels.prototype.initialize = function(options) {
        _.bindAll(this, 'add_label', 'fetch_labels');
        this.github_user_id = options["github_user_id"];
        this.github_repo_name = options["github_repo_name"];
        this.url = "/api/issues_label/" + this.github_user_id + "/" + this.github_repo_name;
        return this;
      };

      Labels.prototype.add_label = function(label_info) {
        var _this = this;
        return this.create({
          label_name: label_info.name,
          label_color: label_info.color,
          csrf_token: Common.Utils.get_csrf_token()
        }, {
          success: function() {
            var key;
            key = Backbone.fetchCache.getCacheKey(_this);
            Backbone.fetchCache.clearItem(key);
            return _this.fetch_labels();
          }
        });
      };

      Labels.prototype.fetch_labels = function() {
        var _this = this;
        return this.fetch({
          cache: true,
          data: {
            csrf_token: Common.Utils.get_csrf_token()
          },
          url: "/api/issues_labels/" + this.github_user_id + "/" + this.github_repo_name,
          dataType: "json"
        }).done(function(labels) {
          _(labels).each(function(label) {
            return _this.add(label);
          });
          return _this.trigger("fetch-end");
        });
      };

      return Labels;

    })(Backbone.Collection);
    return Labels;
  });

}).call(this);
