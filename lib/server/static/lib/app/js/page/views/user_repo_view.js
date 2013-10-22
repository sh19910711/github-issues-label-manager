(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["underscore", "jquery", "backbone", "app/common", "app/labels"], function(_, $, Backbone, Common, Labels) {
    var UserRepoView, _ref;
    UserRepoView = (function(_super) {
      __extends(UserRepoView, _super);

      function UserRepoView() {
        this.event_add_label = __bind(this.event_add_label, this);
        this.event_update_labels = __bind(this.event_update_labels, this);
        _ref = UserRepoView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      UserRepoView.prototype.id = "page-view";

      UserRepoView.prototype.initialize = function(options) {
        _.bindAll(this, "render", "event_update_labels", "event_add_label");
        this.issues_labels = new Labels.Collections.Labels(options.issues_labels);
        return this.issues_labels_view = new Labels.Views.LabelsView({
          collection: this.issues_labels
        });
      };

      UserRepoView.prototype.events = function() {
        return {
          "click button.update": "event_update_labels",
          "click .add button": "event_add_label"
        };
      };

      UserRepoView.prototype.render = function() {
        this.$el.empty();
        this.$el.append("<div class=\"add form-inline\">" + "<div class=\"form-group\">" + "<label class=\"sr-only\">New Label</label>" + "<input id=\"new-label-name\" type=\"text\" class=\"form-control\" placeholder=\"New Label Name\">" + "</div>" + "<button type=\"submit\" class=\"btn btn-primary\">Add</button>" + "</div>");
        this.$el.append("<hr>");
        this.$el.append("<h3>Issues Labels</h3>");
        this.$el.append(this.issues_labels_view.render().el);
        return this;
      };

      UserRepoView.prototype.event_update_labels = function() {
        return this.issues_labels_view.collection.fetch_new_labels();
      };

      UserRepoView.prototype.event_add_label = function() {
        var label_name;
        label_name = $("input#new-label-name").val();
        return this.issues_labels.add_label.call(this.issues_labels, {
          name: label_name,
          color: "FF0000"
        });
      };

      return UserRepoView;

    })(Backbone.View);
    return UserRepoView;
  });

}).call(this);
