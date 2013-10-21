(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["com/backbone/backbone", "com/underscore/underscore", "app/utils", "app/models/issues_label"], function(Backbone, _, Utils, IssuesLabel) {
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
        return this.github_repo_name = options["github_repo_name"];
      };

      IssuesLabels.prototype.fetch_labels = function() {
        var self;
        self = this;
        return this.fetch({
          type: "post",
          data: {
            github_user_id: this.github_user_id,
            github_repo_name: this.github_repo_name,
            csrf_token: Utils.get_csrf_token()
          },
          url: "/api/get_issues_labels",
          dataType: "json"
        }).done(function(labels) {
          self.reset();
          _(labels).each(function(label) {
            return self.add(label);
          });
          return self.trigger("fetch-end");
        }).fail(function() {
          throw new Error("fail on IssuesLabels#fetch_labels");
        });
      };

      IssuesLabels.prototype.fetch_new_labels = function() {
        var self;
        self = this;
        this.trigger("fetch-start");
        return this.fetch({
          type: "post",
          data: {
            github_user_id: this.github_user_id,
            github_repo_name: this.github_repo_name,
            csrf_token: Utils.get_csrf_token()
          },
          url: "/api/get_new_issues_labels",
          dataType: "json"
        }).done(function(labels) {
          self.reset();
          _(labels).each(function(label) {
            return self.add(label);
          });
          return self.trigger("fetch-end");
        }).fail(function() {
          throw new Error("fail on IssuesLabels#fetch_new_labels");
        });
      };

      return IssuesLabels;

    })(Backbone.Collection);
  });

}).call(this);
