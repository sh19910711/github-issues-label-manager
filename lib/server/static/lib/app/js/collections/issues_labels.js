(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "underscore", "com/backbone/backbone-fetch-cache", "app/utils", "app/models/issues_label"], function(Backbone, _, dummy1, Utils, IssuesLabel) {
    var IssuesLabels, _ref;
    return IssuesLabels = (function(_super) {
      __extends(IssuesLabels, _super);

      function IssuesLabels() {
        _ref = IssuesLabels.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      IssuesLabels.prototype.model = IssuesLabel;

      IssuesLabels.prototype.initialize = function(options) {
        this.github_user_id = options["github_user_id"];
        this.github_repo_name = options["github_repo_name"];
        return this;
      };

      IssuesLabels.prototype.fetch_labels = function() {
        var self;
        self = this;
        return this.fetch({
          cache: true,
          type: "get",
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

      IssuesLabels.prototype.fetch_new_labels = function() {
        var self;
        self = this;
        return this.fetch({
          type: "put",
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
