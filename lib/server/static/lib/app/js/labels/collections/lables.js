(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "underscore", "app/common", "com/backbone/backbone-fetch-cache"], function(Backbone, _, Common) {
    var Labels, _ref,
      _this = this;
    Labels = (function(_super) {
      __extends(Labels, _super);

      function Labels() {
        _ref = Labels.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Labels.prototype.model = Label;

      Labels.prototype.initialize = function(options) {
        _.bindAll(this, 'add_label', 'fetch_labels');
        this.github_user_id = options["github_user_id"];
        this.github_repo_name = options["github_repo_name"];
        this.url = "/api/issues_label/" + this.github_user_id + "/" + this.github_repo_name;
        return this;
      };

      return Labels;

    })(Backbone.Collection);
    _(Labels.prototype).extend({
      add_label: function(label_info) {
        return _this.create({
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
      },
      fetch_labels: function() {
        return _this.fetch({
          cache: true,
          data: {
            csrf_token: Common.Utils.get_csrf_token()
          },
          url: "/api/issues_labels/" + _this.github_user_id + "/" + _this.github_repo_name,
          dataType: "json"
        }).done(function(labels) {
          _(labels).each(function(label) {
            return this.add(label);
          });
          return _this.trigger("fetch-end");
        });
      }
    });
    return Labels;
  });

}).call(this);
