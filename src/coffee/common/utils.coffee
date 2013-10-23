define(
  [
    "underscore"
    "jquery"
    "app/common"
  ]
  (
    _
    $
    Common
  )->
    class Utils
      @get_csrf_token: ->
        $("meta[data-csrf-token]").data("csrf-token")

      @get_login_user: ->
        github_user_id: $("meta[data-login-user-github-user-id]").data("login-user-github-user-id")

      @get_root: ->
        window

)
