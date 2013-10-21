(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "app/collections/issues_labels", "app/views/issues_labels", "app/utils"], function(Backbone, IssuesLabels, IssuesLabelsView, Utils) {
    var UserRepoPageView, _ref;
    return UserRepoPageView = (function(_super) {
      __extends(UserRepoPageView, _super);

      function UserRepoPageView() {
        _ref = UserRepoPageView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      UserRepoPageView.prototype.initialize = function(options) {
        _.bindAll(this, ["render"]);
        this.issues_labels = new IssuesLabels(options.issues_labels);
        return this.issues_labels_view = new IssuesLabelsView({
          collection: this.issues_labels
        });
      };

      UserRepoPageView.prototype.events = function() {
        return {
          "click button.update": "event_update_labels"
        };
      };

      UserRepoPageView.prototype.render = function() {
        this.$el.empty();
        this.$el.append("<button class='update btn btn-primary'>Update Labels</button>");
        this.$el.append("<hr>");
        this.$el.append("<h3>Issues Labels</h3>");
        this.$el.append(this.issues_labels_view.render().el);
        return this;
      };

      UserRepoPageView.prototype["event_update_labels"] = function() {
        return this.issues_labels_view.collection.fetch_new_labels();
      };

      return UserRepoPageView;

    })(Backbone.View);
  });

}).call(this);
