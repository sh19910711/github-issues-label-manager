(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["underscore", "jquery", "backbone", "app/common"], function(_, $, Backbone, Common) {
    var IssuesLabelsView, _ref;
    return IssuesLabelsView = (function(_super) {
      __extends(IssuesLabelsView, _super);

      function IssuesLabelsView() {
        _ref = IssuesLabelsView.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      IssuesLabelsView.prototype.tagName = "table";

      IssuesLabelsView.prototype.className = "table table-striped";

      IssuesLabelsView.prototype.initialize = function(options) {
        _.bindAll(this, ["render"]);
        this.collection.on("fetch-end", function() {
          return this.render();
        }, this);
        this.collection.fetch_labels();
        return this;
      };

      IssuesLabelsView.prototype.render = function() {
        this.$el.empty();
        this.collection.each(function(label) {
          return this.$el.append("<tr>" + "<td>" + ("" + (label.get("name"))) + "</td>" + "</tr>");
        }, this);
        return this;
      };

      return IssuesLabelsView;

    })(Backbone.View);
  });

}).call(this);
