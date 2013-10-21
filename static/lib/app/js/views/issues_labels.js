(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["com/backbone/backbone", "com/underscore/underscore"], function(Backbone, _) {
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
        var self;
        _.bindAll(this, ["render"]);
        self = this;
        this.collection.on("fetch-end", function() {
          return self.render();
        });
        return this.collection.fetch_labels();
      };

      IssuesLabelsView.prototype.render = function() {
        var self;
        self = this;
        this.$el.empty();
        this.collection.each(function(label) {
          return self.$el.append("<tr>" + "<td>" + ("" + (label.get("name"))) + "</td>" + "</tr>");
        });
        return this;
      };

      return IssuesLabelsView;

    })(Backbone.View);
  });

}).call(this);
