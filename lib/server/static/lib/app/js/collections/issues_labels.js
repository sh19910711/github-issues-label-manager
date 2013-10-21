(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "underscore", "com/backbone/backbone-fetch-cache", "app/utils", "app/models/issues_label"], function(Backbone, _, dummy1, Utils, IssuesLabel) {
    var IssuesLabels, _ref;
    return IssuesLabels = (function(_super) {
      __extends(IssuesLabels, _super);

      function IssuesLabels() {
        this.fetch_labels = __bind(this.fetch_labels, this);
        this.add_label = __bind(this.add_label, this);
        _ref = IssuesLabels.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      IssuesLabels.prototype.model = IssuesLabel;

      IssuesLabels.prototype.initialize = function(options) {
        _.bindAll(this, 'add_label', 'fetch_labels');
        this.github_user_id = options["github_user_id"];
        this.github_repo_name = options["github_repo_name"];
        this.url = "/api/issues_label/" + this.github_user_id + "/" + this.github_repo_name;
        return this;
      };

      IssuesLabels.prototype.add_label = function(label_info) {
        var self;
        self = this;
        return this.create({
          label_name: label_info.name,
          label_color: label_info.color,
          csrf_token: Utils.get_csrf_token()
        }, {
          success: function() {
            var key;
            key = Backbone.fetchCache.getCacheKey(this);
            Backbone.fetchCache.clearItem(key);
            return self.fetch_labels();
          }
        });
      };

      IssuesLabels.prototype.fetch_labels = function() {
        var self;
        self = this;
        return this.fetch({
          cache: true,
          data: {
            csrf_token: Utils.get_csrf_token()
          },
          url: "/api/issues_labels/" + this.github_user_id + "/" + this.github_repo_name,
          dataType: "json"
        }).done(function(labels) {
          _(labels).each(function(label) {
            return self.add(label);
          });
          return self.trigger("fetch-end");
        });
      };

      return IssuesLabels;

    })(Backbone.Collection);
  });

}).call(this);
