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
          "click button.update": "event_update_labels",
          "click .add button": "event_add_label"
        };
      };

      UserRepoPageView.prototype.render = function() {
        this.$el.empty();
        this.$el.append("<div class=\"add form-inline\">" + "<div class=\"form-group\">" + "<label class=\"sr-only\">New Label</label>" + "<input id=\"new-label-name\" type=\"text\" class=\"form-control\" placeholder=\"New Label Name\">" + "</div>" + "<button type=\"submit\" class=\"btn btn-primary\">Add</button>" + "</div>");
        this.$el.append("<hr>");
        this.$el.append("<h3>Issues Labels</h3>");
        this.$el.append(this.issues_labels_view.render().el);
        return this;
      };

      UserRepoPageView.prototype.event_update_labels = function() {
        return this.issues_labels_view.collection.fetch_new_labels();
      };

      UserRepoPageView.prototype.event_add_label = function() {
        var label_name;
        label_name = $("input#new-label-name").val();
        return this.issues_labels.add_label.call(this.issues_labels, {
          name: label_name,
          color: "FF0000"
        });
      };

      return UserRepoPageView;

    })(Backbone.View);
  });

}).call(this);
