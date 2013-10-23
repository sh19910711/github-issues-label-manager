define(
  [
    "./views/user_repo_view"
    "./views/user_repos_view"
  ]
  (UserRepoView, UserReposView)->
    class Views
      @UserRepoView: UserRepoView
      @UserReposView: UserReposView
)
