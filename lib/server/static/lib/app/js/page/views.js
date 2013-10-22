(function() {
  define(["./views/user_repo_view", "./views/user_repos_view"], function(UserRepoView, UserReposView) {
    var Views;
    return Views = (function() {
      function Views() {}

      Views.UserRepoView = UserRepoView;

      Views.UserReposView = UserReposView;

      return Views;

    })();
  });

}).call(this);
