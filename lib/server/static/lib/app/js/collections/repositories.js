(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(["backbone", "underscore", "com/backbone/backbone-fetch-cache", "app/utils", "app/models/repository"], function(Backbone, _, dummy1, Utils, Repository) {
    var Repositories, _ref;
    return Repositories = (function(_super) {
      __extends(Repositories, _super);

      function Repositories() {
        _ref = Repositories.__super__.constructor.apply(this, arguments);
        return _ref;
      }

      Repositories.prototype.model = Repository;

      Repositories.prototype.initialize = function(options) {
        this.github_user_id = options["github_user_id"];
        return this;
      };

      Repositories.prototype.fetch_repos = function() {
        var self;
        self = this;
        return this.fetch({
          cache: true,
          type: "get",
          data: {
            csrf_token: Utils.get_csrf_token()
          },
          url: "/api/repos/" + this.github_user_id,
          dataType: "json"
        }).done(function(repos) {
          _(repos).each(function(repo) {
            return self.add(repo);
          });
          return self.trigger("fetch-end");
        });
      };

      Repositories.prototype.fetch_new_repos = function() {
        var self;
        self = this;
        return this.fetch({
          type: "put",
          url: "/api/repos/" + this.github_user_id,
          data: {
            csrf_token: Utils.get_csrf_token()
          },
          dataType: "json"
        }).done(function(repos) {
          _(repos).each(function(repo) {
            return self.add(repo);
          });
          return self.trigger("fetch-end");
        });
      };

      return Repositories;

    })(Backbone.Collection);
  });

}).call(this);
