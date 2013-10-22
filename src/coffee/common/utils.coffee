define(
  [
    "jquery"
  ]
  ($)->
    class Utils

      @get_csrf_token: ->
        $("meta[data-csrf-token]").data("csrf-token")

      @get_login_user: ->
        github_user_id: $("meta[data-login-user-github-user-id]").data("login-user-github-user-id")

      @get_root: ->
        window

      @request_api: (path)->
        $.ajax(
          url: "/api/#{path}"
          type: "POST"
          dataType: "json"
          data:
            csrf_token: @get_csrf_token()
        )

)
