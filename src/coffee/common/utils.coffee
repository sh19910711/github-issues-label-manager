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

      @get_server_version: ->
        $("meta[data-server-version]").data("server-version")

      # return true if v1 < v2
      @compare_version: (v1, v2)->
        a1 = v1.split(".").map (v)->
          parseInt v, 10
        a2 = v2.split(".").map (v)->
          parseInt v, 10
        len = Math.min a1.length, a2.length
        _([0..len-1]).some (i)->
          a1[i] < a2[i]
)
